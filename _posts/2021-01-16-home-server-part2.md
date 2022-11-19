---
title:  "My Home Server - Part 2"
tags: ["Linux", "Server", "Proxmox", "ZFS", "VFIO", "Gaming"]

header:
  teaser: /assets/imgs/2021-01-16-home-server-part2/IMG_20210116_201125.jpg

gallery:   
  - url: /assets/imgs/2021-01-16-home-server-part2/IMG_20210116_201125.jpg
    image_path: /assets/imgs/2021-01-16-home-server-part2/IMG_20210116_201125.jpg
  - url: /assets/imgs/2021-01-16-home-server-part2/IMG_20210108_163511.jpg
    image_path: /assets/imgs/2021-01-16-home-server-part2/IMG_20210108_163511.jpg

gallery2:
  - url: /assets/imgs/2021-01-16-home-server-part2/IMG_20210116_201333.jpg
    image_path: /assets/imgs/2021-01-16-home-server-part2/IMG_20210116_201333.jpg
---

In the last part, I wrote how I built my home server, and what I upgraded.
I still had a few problems after the upgrade, mainly the amount of ram and some missing functionality.

{% include gallery caption="Gaming \ Home Server" %}

## What I Had

I have the following gaming PC, which I use as a Linux workstation and a gaming VM using [VFIO](https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF).

- Gigabyte X570 Aorus Elite
- AMD Ryzen 5 3600
- 16G 3600 DDR4
- RX580 (Guest GPU)
- R7750 (Host GPU)

I also have the home server I've written about in the [previous post](https://nevoef.com/home-server-part1/).

I wanted to build a single computer out of both PCs I had, using the MB, CPU, and GPUs from the gaming PC and the Case, HBA, and disks from my former server.
I'm using Proxmox as a host OS, and use the PC as my Linux workstation, gaming PC as well as running all my server needs simultaneously without hurting performance.

To accomplish this I had to acquire some parts and do some modifications.

## New Parts

### RAM

First I had to upgrade the RAM in the system, I bought 64G of DDR4 3600 non-ECC memory.

Although I'm using ZFS, for which ECC memory is recommended, I'm not hosting any real critical data and all the important data is backed up to the cloud. So I decided ECC memory is not worth the cost in my case.

### SSD Drive Cage

I now have a total of 5x 2.5\" SSDs on my system:

- 250G - Proxmox hypervisor
- 2x 250G ZFS raid1 - VMs storage
- 500G - Linux workstation
- 500G - Windows games

I also have one NVME SSD for Windows OS.

My case only has slots for 2x 2.5" SSDs, so I got an [SSD drive cage](https://www.amazon.com/gp/product/B01M0BIPYC) that can hold up to 6x 2.5\" drives using one 5.25\" slot.

{% include gallery id="gallery2" caption="SSD Drive Cage" layout="half" %}

### PCIe Adapter

I wanted to connect the smaller GPU to an x1 PCIe slot and mount it vertically in the case. I tried two different adapter cables before I found the [adapter](https://s.click.aliexpress.com/e/_9z6TKn) that suited the task.

For mounting the GPU in the vertical slot I had to cut it using a Dremel to fit. Definitely wouldn't have tried it on a modern GPU...

### USB3 PCIe Card

I want both VMs to have a discrete USB3 controller passthrough to it, so I can connect high-speed peripherals to every VM easily.
The Linux VM is getting one of the motherboard USB3 controllers.
I got [this card](https://www.aliexpress.com/item/4001299190568.html) for the Windows VM, unfortunately, it didn't arrive until now so I haven't tested it yet.

## Software

After a bit of research, I've decided to stick with Proxmox as the host OS, because I can have all the functionality of a full hypervisor and also have decent performance when using VFIO.

I'm using [Barrier](https://github.com/debauchee/barrier) to switch control between the VMs, I also have a physical USB-KVM as a backup.

For sound, I'm using [Scream](https://github.com/duncanthrax/scream) to stream audio from the Windows VM to the Linux VM. At first, I wanted to use my USB sound-card on the passthrough USB3 controller, but I had some crackling issues. I've ended up using my MB sound-card using PCIe passthrough.

## Conclusion

I've found Proxmox to be a great software for both a hypervisor and a host for a gaming VM. Performance is almost identical to VFIO on ArchLinux I've used before (and will probably get better with 5.10 kernel).

NAS traffic is in-memory and transfer speeds are insane thanks to ZFS ARC. This alone eliminated my need for 10G networking at home (no other client except my workstation needs 10G).

My current CPU is decent but I'll probably upgrade it in the future to a more recent Ryzen 9 CPU. CPU cooling should also be replaced as it's insufficient already.
