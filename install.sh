#!/bin/bash
set -eu
set -o pipefail

if [ "$(id -u)" -ne 0 ]
then
  echo "Please run as root" >&2
  exit
fi

cd -- "$(dirname -- "$BASH_SOURCE")"

export DEBIAN_FRONTEND=noninteractive

files=(
    etc/systemd/system/benchmark-setup.service
    opt/benchmark/setup.sh
    opt/benchmark/shield.sh
    usr/local/bin/shield
)

set -x
apt-get install -yq linux-cpupower cpuset

for file in "${files[@]}"
do
    mkdir -p "$(dirname "/$file")"
    cp -d --preserve=mode "$file" "/$file"
    chown root:root "/$file"
done

systemctl daemon-reload
systemctl enable benchmark-setup.service
systemctl restart benchmark-setup.service
