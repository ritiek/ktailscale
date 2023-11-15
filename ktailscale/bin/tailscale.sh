#!/bin/sh

_KH_FUNCS="/mnt/us/usbnet/bin/libkh5"
. "${_KH_FUNCS}"

KH_HACKNAME="${PWD##/mnt/us/extensions/}"
EXTENSION=/mnt/us/extensions/${KH_HACKNAME}


start() {
  kh_msg "* starting tailscaled *" I v
  ${EXTENSION}/bin/tailscaled --cleanup
  ${EXTENSION}/bin/tailscaled --tun=userspace-networking &
  kh_msg "* starting tailscale *" I v
  ${EXTENSION}/bin/tailscale up --accept-dns=true
  kh_msg "* started tailscale *" I v
}

stop() {
  kh_msg "* stopping tailscale *" I v
  ${EXTENSION}/bin/tailscale down
  ${EXTENSION}/bin/tailscaled --cleanup
  kh_msg "* stopped tailscale *" I v
}


## Main
case "${1}" in
        "start" )
                ${1}
        ;;
        "stop" )
                ${1}
        ;;
        * )
                kh_msg "invalid action (${1})" W v "invalid action"
        ;;
esac
