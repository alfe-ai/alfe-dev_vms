#!/bin/bash

DISK_IMAGE="/mnt/part7/windows11.qcow2"

# Check if disk image file exists
if [ ! -f "$DISK_IMAGE" ]; then
  echo "Error: Disk image '$DISK_IMAGE' not found."
  exit 1
fi

ISO_OPTIONS=""
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
