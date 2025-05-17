#!/bin/bash

DISK_IMAGE="/mnt/part7/windows11.qcow2"
ISO_OPTIONS=""

# If an ISO path is provided, add it to the QEMU options.
if [ "$#" -ge 1 ]; then
  ISO_PATH="$1"
  ISO_OPTIONS="-cdrom $ISO_PATH -boot d"
fi

qemu-system-x86_64 \
  -enable-kvm \
  -cpu host \
  -m 4G \
  -vga virtio \
  -drive file="$DISK_IMAGE",format=qcow2 \
  $ISO_OPTIONS \
  -netdev user,id=net0 \
  -device e1000,netdev=net0 \
  -device virtio-balloon
