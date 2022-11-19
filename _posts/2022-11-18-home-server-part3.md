---
title:  "My Home Server(s) - Part 3"
tags: ["Linux", "Server", "Proxmox", "ZFS", "NAS", "K8S"]

header:
  teaser: /assets/imgs/nas-pics_20221118_0051_2309.jpg

gallery:   
  - url: /assets/imgs/nas-pics_20221118_0051_2309.jpg
    image_path: /assets/imgs/nas-pics_20221118_0051_2309.jpg
  - url: /assets/imgs/2022-11-18-home-server-part3/containers_aerial_view_shipping_by_stocksnap_cc0_via_pixabay-100740403-large.jpg
    image_path: /assets/imgs/2022-11-18-home-server-part3/containers_aerial_view_shipping_by_stocksnap_cc0_via_pixabay-100740403-large.jpg

gallery2:
  - url: /assets/imgs/2022-11-18-home-server-part3/photo_2022-11-18_18-45-33.jpg
    image_path: /assets/imgs/2022-11-18-home-server-part3/photo_2022-11-18_18-45-33.jpg
---


In this chapter, I will explain my current home server(s) setup and my Kubernetes cluster.

{% include gallery caption="My Homelab" %}

## The Motives

Over the years I had my home services running in docker containers, and managed by a Docker compose. This solution was working but was hard to upgrade and back up.
I wanted to learn K8S and also upgrade the way my cluster works.

In addition to that, I had my combined Gaming PC and server described in the [previous post](/home-server-part2/). It was operating perfectly but had a few downsides:

* Required a giant case to fit a GPU and 6 Drives, which takes a lot of space and is extremely heavy and hard to move.
* Required a Power-hungry CPU to be running 24/7 which is not needed for a simple NAS or a server.
* Maintainance and periodic updates required downtime of all systems and were hard to troubleshoot.

So I decided to separate this single computer into 3 different machines:

1. The Compute Server - 1L PC with a modern medium-tier CPU and enough RAM to run all of my VMs needs(and K8S cluster).
2. NAS server with low-end but efficient CPU and a lot of RAM for cache.
3. Gaming PC With a single GPU for gaming and editing needs.

The first two should be power-efficient and silent while the third Gaming PC should have great airflow and doesn't need to be the most power-efficient. All of them should take up the least space possible.

## The Compute Server

I choose the Lenovo Tiny m720q with I5-9400t which I got used from eBay.
This is one of the only 1L PCs that exist that can accommodate a 10G networking card using its PCIe slot.

It'll be running Proxmox as my home hypervisor and my single-node K8S cluster will reside inside one of the VMs.
If in the future I'll require more computing or additional K8S nodes I can just buy more PCs like this one.

My current setup is a single node Kubernetes cluster, deployed using [Flux](https://toolkit.fluxcd.io/). I'm using the genius [Renovate](https://www.mend.io/free-developer-tools/renovate/) tool which automatically opens PRs for me when there's any update to any of the services I run.

I tried doing a multi-node cluster but for my use case, it wasn't worth the power draw and the extra memory needed for decentralized storage.

The cluster is open-source and you can see it [here](https://github.com/VoliKoN/k3s-gitops).

## The NAS

Although I could get a pre-made NAS, I wanted to build it myself. Firstly to save costs and also to be able to run custom software and have a lot of RAM for cache.

I used this [excellent case](https://s.click.aliexpress.com/e/_DkV397t) From Ali that allows me to have 6 drives in hot-swappable cages, while still being small and cheap.

The fans in the case turned out to be loud, so I had to do some ugly hacks and print an adapter to use some silent fans I had laying around. I will put some proper fans I ordered once they arrive.

{% include gallery id="gallery2" caption="Ugly Hacks \ I promise I won't keep it like this!" layout="half" %}

For software, I tried TrueNAS Scale but didn't like the fact that `apt` is locked, so I kept with Proxmox using the zfs, nfs, smb combination I had in the last server.

## Conclusion

This setup is more power-efficient, easy-serviceable, and space-constrained than what I had before.

I still need to upgrade to SATA drives which are quieter and more power-efficient than the SAS drives I have now.
