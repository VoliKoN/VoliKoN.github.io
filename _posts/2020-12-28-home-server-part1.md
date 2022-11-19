---
title:  "My Home Server - Part 1"
tags: ["Linux", "Server", "Proxmox", "ZFS"]

header:
  teaser: /assets/imgs/2020-12-07-home-server-part1/photo_2020-12-28_19-02-21.jpg

gallery:   
  - url: /assets/imgs/2020-12-07-home-server-part1/photo_2020-12-28_19-02-21.jpg
    image_path: /assets/imgs/2020-12-07-home-server-part1/photo_2020-12-28_19-02-21.jpg
  - url: /assets/imgs/2020-12-07-home-server-part1/photo_2020-12-28_19-02-42.jpg
    image_path: /assets/imgs/2020-12-07-home-server-part1/photo_2020-12-28_19-02-42.jpg
---
I built my home server somewhere around 2017, and it's been working great since.
In this post I’ll explain what I originally had, and what I recently upgraded.

## What I Had

I had the following specs inside an old case that I had [modified](https://i.kym-cdn.com/entries/icons/original/000/019/022/download.jpg) to fit an E-ATX motherboard.

* SuperMicro X8DTL-3F
* 1x Xeon E5645
* 3x 8GB DDR3 ECC (24GB Total)
* 4TB HDD - Main storage
* 256 ssd - VM storage

I bought a used dual-CPU motherboard with the hope that someday I'll add another CPU and double the performance. This plan turned out to be not power-efficient enough.

This was running Proxmox and a variety of different VMs. It was running well but was missing a few things:

1. Storage Redundancy and capacity - 4TB was enough at the time, but quickly got filled up. Also, all the data relied on a single hard drive.
2. VM storage was a bit slow and not redundant.
3. Case noise and airflow - The old case I was using didn't have any sort of sound dampening or isolation. Also, I had to make holes and add fans in places that were never designed to hold fans in the size I wanted or any fans at all...
4. Power usage - I've never actually measured, but I assume power usage was a bit too high for a home server.
5. RAM and CPU - Once I've moved to a ZFS file system, the RAM I had wasn't enough. Also, the CPU is lagging at times.

I've decided to upgrade some parts to fix problems 1-3. I'll address problems 4 and 5 in a future post.

## What I did

### Storage Array

After a lot of reading and learning, I've decided on ZFS as my raid and storage solution.

* HBA - I bought a perc h200 raid card and flashed it to IT-mode, this was a cheap and easy way to add 8 SAS ports to my server.
* Drives - I bought 7 used Seagate 4TB SAS drives. I wanted to set it up as a 6-drive raid-z2 array. And to have another drive as a cold spare.
* SAS Cable - I bought this awesome [cable](https://s.click.aliexpress.com/e/_A1dzeR). This allowed me to have SAS drives inside a desktop case without a proper SAS backplane.

Setting up a ZFS array with Proxmox was a breeze. I've set up and tested monitoring with ZFS-zed, Logwatch, and Telegraf(with an Influxdb and Grafana interface). I've also set up automatic snapshots using [snaoid](https://github.com/jimsalterjrs/sanoid).

This [blog post](https://techblog.jeppson.org/2019/08/using-proxmox-as-a-nas/) helped me a lot with setting up all the necessary software.

### VM Storage

For VM Storage, I've decided to set up a ZFS mirror of two 240GB consumer SSDs. I don't care about redundancy here, but I do care about data reliability.
From my understanding of ZFS, having disk redundancy will help ZFS know better if any data was corrupted, and silently fix it from the other drive. But I could be wrong here...

This will probably be upgraded to a ZFS Raid-10 of 4 SSDs in the future.

### Case Noise & Airflow

After long research about desktop tower cases as NASs \ home servers, I've settled on the Fractal Define R6.

The R6 supports an E-ATX motherboard, 9 fans, and 6 3.5" hard drives (11 with extra trays).

All of this while being silent and relatively cheap.

{% include gallery caption="My Home Server" %}

## After Thoughts

The server is now much better and has improved in many aspects, but there are some things I would have done differently.

The SAS Drives are extremely noisy and produce a huge amount of heat compared to regular SATA drives. I'm not sure I'll choose SAS next time I buy drives. Also, maybe it could be smarter to have 4 bigger drives in a raid-10 compared to the 6 in raid-z2 I have now.

RAM, I always need more RAM.

Seriously, Having a 24TB ZFS array (Around 16TB Usable) requires a huge amount of RAM. I think with my increasing VMs memory needs and the ZFS array I will need to have at least 48GB of RAM.

My next project would be combining my gaming pc with this server, using VFIO on Proxmox. Stay Tuned!
