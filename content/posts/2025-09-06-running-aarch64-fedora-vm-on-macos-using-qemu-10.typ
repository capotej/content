#let meta = (
  title: "Running an aarch64 Fedora VM on MacOS using QEMU 10",
  date: "2025-09-06",
  tags: ("linux", "macos", "vm"),
  draft: false,
  redirect_from: "/blog/2025/09/06/running-aarch64-fedora-vm-on-macos-using-qemu-10",
)
#context metadata((meta))

= Running an aarch64 Fedora VM on MacOS using QEMU 10

=== "Works on my machine"

The following configuration works on my 2021 M1 Max laptop running MacOS Sequoia 15.6.1.

=== ARM Architecture

Most of the guides I found were focused on emulating `amd64`/`x86-64` architectures. This guide instead targets the `aarch64`/`arm64` architecture (same as the host system) to minimize emulation overhead.

=== Steps

These steps should get you a Fedora Server VM that you can SSH into from your host OS.

==== Install QEMU

```shell
$ brew install qemu
```

==== Download Fedora Server filesystem image

Thankfully, Fedora provides ready-to-go filesystem images on their #link("https://fedoraproject.org/server/download")[downloads] page. Download the QEMU `qcow2` filesystem image for the latest server version (42 as of writing).

==== Resize the Fedora Server filesystem image

The Fedora Server image downloaded in the previous step is only large enough to fit the base installation and will likely need to be resized for your needs. You can use `qemu-img` to resize it like so:

```shell
$ qemu-img resize Fedora-Server-Guest-Generic-42-1.1.aarch64.qcow2 15G
```

Where `15G` is the target size.

==== Create a startup script `start.sh`

Create a file `start.sh` that will contain the `qemu` invocation for your new VM.

I found it helpful to check this script into git while iterating on different qemu arguments so I could rollback to working versions.

The script:

```shell
qemu-system-aarch64 \
    -name "Fedora" \
    -machine type=virt,iommu=smmuv3 \
    -accel hvf \
    -cpu cortex-a57 \
    -smp 4 \
    -m 2048 \
    -rtc base=utc \
    -drive if=pflash,format=raw,file="/opt/homebrew/share/qemu/edk2-aarch64-code.fd",readonly=on \
    -drive if=pflash,format=raw,file="/opt/homebrew/share/qemu/edk2-arm-vars.fd" \
    -drive file="Fedora-Server-Guest-Generic-42-1.1.aarch64.qcow2",if=virtio,format=qcow2 \
    -boot menu=on \
    -display default \
    -device virtio-gpu \
    -nic user,id=NAT,model=virtio-net-pci,mac=02:00:00:00:00:01,hostfwd=tcp::2222-:22 \
    -device qemu-xhci \
    -device usb-kbd \
    -device usb-tablet
```

===== Argument Explanation

Some of these arguments are worth paying attention to, I'll list the important ones below.

- `accel hvf`: This sets the acceleration framework to the use native #link("https://developer.apple.com/documentation/hypervisor")[MacOS Hypervisor Framework].

- `m 2048`: Give the VM 2GB of RAM.

- `smp 4`: Give the VM 4 CPUs.

- `-nic user,id=NAT,model=virtio-net-pci,mac=02:00:00:00:00:01,hostfwd=tcp::2222-:22`: The `hostfwd` option forwards port 2222 on the host OS to port 22 (ssh) on the guest OS.

==== Start the VM

Boot up the VM using `start.sh`

```shell
$ sh start.sh
```

You should see a window open up like so:

#html.elem("img", attrs: (
  src: "/assets/2025-09-06-qemu-vm-1.png",
  alt: "Screenshot 2025-09-06 at 3.12.26 PM.png",
))

Then you'll see it say "Display output is not active.", this is okay, just wait a bit, eventually you will see the machine boot.

#html.elem("img", attrs: (
  src: "/assets/2025-09-06-qemu-vm-2.png",
  alt: "Screenshot 2025-09-06 at 3.13.30 PM.png",
))

==== Configure Fedora Server

The first time you boot Fedora Server there is a clunky setup text UI thing for setting up a non-root user and giving it a password. Once this is done and you can hit `c` to continue, your VM is good to go.

==== SSH from Host OS

You should now be able to SSH into the Guest OS using the username and password created in the previous step by using port 2222, like so:

```shell
$ ssh capotej@localhost -P 2222
```

==== Grow Guest filesystem to use new size

In order for the Guest OS to take advantage of new size from the `qemu-resize` above, we need to grow the root partition as well as extend our logical volume using the commands below.

===== Extend the partition

```shell
$ sudo growpart /dev/vda 3
```

===== Extend the physical volume

```shell
$ sudo pvresize /dev/vda3
```

===== Extend the logical volume

```shell
$ sudo lvextend -l +100%FREE /dev/systemVG/LVRoot
```

===== Resize the filesystem

```shell
$ sudo xfs_growfs /
```

===== Verify extra space

You can verify that `/` has more space by running `df` like so

```shell
$ df -h /
```

==== Shutting down the VM

You can use the standard `shutdown` command to shutdown the VM while logged into ssh:

```shell
$ sudo shutdown -h now
```

==== Headless Mode

Once you have your VM setup, you can edit `start.sh` and change `display` to :

```shell
-display none -serial null \
```

Then when you run `start.sh` it will run the VM in the foreground without a display. You can use `Ctrl-C` to stop the VM from the host OS.

Your VM should now be ready for experimentation, happy VMing!
