#!/bin/sh
set -eu

if [ "$(id -u)" -ne 0 ]
then
  echo "Please run as root" >&2
  exit
fi

cset shield -e sudo -- -u "#$SUDO_UID" SHIELDED=1 -- "$@"
