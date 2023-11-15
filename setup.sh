#!/bin/sh

DOWNLOAD_URL=${1}

FILENAME="${DOWNLOAD_URL##*/}"
DIRECTORY="${FILENAME%.*}"

if [[ ${DIRECTORY} != "tailscale"* || ${DIRECTORY} != *"arm" ]]; then
  echo "Tailscale ARM static binary archive url doesn't look right"
  exit 1
fi

VERSION="${DIRECTORY#*_}"
VERSION="${VERSION%%_*}"

DATE="$(date +%F)"

set -x

curl ${DOWNLOAD_URL} -o /tmp/${FILENAME}
tar -xvf /tmp/${FILENAME} -C /tmp
mv /tmp/${DIRECTORY}/tailscale{,d} ./kindle.pkg/bin/
rm -rf /tmp/${DIRECTORY}

tar -cvf "./ktailscale_${VERSION}_${DATE}.tar.gz" ./ktailscale
