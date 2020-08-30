---
title:  "Controlling IR Devices From Home Assistant - Part 1"
tags: ["Home Assistant", "Arduino", "Smart Home", "ESPHome"]

gallery:   
  - url: /assets/imgs/2020-08-25-ir-control-part1/IMG_20200825_204727_e.jpg
    image_path: /assets/imgs/2020-08-25-ir-control-part1/IMG_20200825_204727_e.jpg
  - url: /assets/imgs/2020-08-25-ir-control-part1/IMG_20200825_220235_e.jpg
    image_path: /assets/imgs/2020-08-25-ir-control-part1/IMG_20200825_220235_e.jpg
  - url: /assets/imgs/2020-08-25-ir-control-part1/IMG_20200825_220254_e.jpg
    image_path: /assets/imgs/2020-08-25-ir-control-part1/IMG_20200825_220254_e.jpg

gallery2:
  - url: /assets/imgs/2020-08-25-ir-control-part1/Screenshot_2020-08-26_00-17-45.png
    image_path: /assets/imgs/2020-08-25-ir-control-part1/Screenshot_2020-08-26_00-17-45.png

---
The AC units in my home (Electra) are IR controlled, and I wanted a simple way to control them from Home Assistant.

I could use some chinese pre-made devices like the
[Broadlink RM-Mini](https://s.click.aliexpress.com/e/_dUcEswk)
but that will force me to use their closed-source app. And also I think the less chinese malware on my phone and network is probably for the better...

So I've tried installing ESPHome on an `esp8266` device with an IR Led and a receiver on a breadboard, which worked great using the `coolix` [component](https://esphome.io/components/climate/coolix.html).

{% include gallery id="gallery2" caption="Coolix AC on Home Assistant, the 0º should have a value when using a temp sensor." %}

Next I looked for a ready-to-use solution on the `esp8266`/`esp32` platform that I could deploy around my house, but I couldn't find any.

I did find the
[Lolin IR controller](https://www.aliexpress.com/item/32891173618.html)
which is a board that sits on top of a
[D1 Mini](https://www.aliexpress.com/item/32651747570.html)
board. Which is tiny and uses 4 IR leds and a transistor for amplification, it also comes with a receiver as well.

{% include gallery caption="Lolin IR Controller" %}

It works well but doesn't have the full range of the original remote, from my AC unit it has around 2 meters of range.

In conclusion this solution is great for my application but it's missing a temperature sensor and larger leds, maybe in a future project I'll design myself a similar pcb with a built-in `ds18b20` sensor and some beefier leds. A 3D printed case could also be a nice addition.
