#!/bin/sh
set -eu

if [ "$(id -u)" -ne 0 ]
then
  echo "Please run as root" >&2
  exit
fi

file_write() {
  was=$(cat $1)
  echo "$2" >"$1"
  echo "$1 was $was, is now $(cat "$1")"
}

file_write /proc/sys/kernel/randomize_va_space 0
file_write /sys/devices/system/cpu/cpufreq/boost 0
file_write /proc/sys/kernel/perf_event_paranoid 1
file_write /sys/devices/system/cpu/smt/control off

# available frequency steps:  3.70 GHz, 3.20 GHz, 2.20 GHz
cpupower frequency-set -f 3.20GHz
cpupower frequency-info

cset shield -r || true
cset shield -c 4-7 --kthread=on
