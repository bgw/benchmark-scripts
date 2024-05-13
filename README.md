# benchmark configs

This is a set of scripts and config files used for benchmarking. These configs
are hardware-specific, so they likely can't be used to reproduce my test
environment, but they at least serve as documentation.

The goal is to create an extremely low noise benchmarking environment to reduce
noise in measurements (within about 1% variation).

## Hardware

- AMD Ryzen 2700x downclocked to a fixed 3.20 GHz
- 16 GB RAM at 2133 MT/s
- SATA SSD

## High-Level Notes

- Bare-bones Debian 12 without X11/Wayland
- Disable ASLR
- Disable CPU Boost, and fix clocks at 3.20 GHz
- Disable SMT (aka "Hyperthreading")
- Enable `perf` events for non-root users.
- Use [`cpuset`][] to isolate 4 cores, one of the two CCX/chiplets, limiting
  variability in core-to-core and cache latency. Move kernel threads off too.
- Provide a `/usr/local/bin/shield` command to enter the `cpuset` shield (with
  `sudo shield bash`).

[cpuset]: https://github.com/SUSE/cpuset/

## Other Configuration

Install Chrome and disable GPU rasterization so that headless operation works:

```
curl -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt --fix-broken install
google-chrome --headless --disable-gpu --flag-switches-begin --disable-features=EnableGpuRasterization --flag-switches-end
```
