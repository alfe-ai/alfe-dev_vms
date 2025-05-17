#!/bin/bash

DISK_IMAGE="/mnt/part7/windows11.qcow2"
DISK_SIZE="64G"  # Adjust disk size as needed

# Check if the disk image file exists; if not, create it.
if [ ! -f "$DISK_IMAGE" ]; then
  echo "Disk image '$DISK_IMAGE' not found. Creating a new $DISK_SIZE disk image..."
  if ! command -v qemu-img &> /dev/null; then
    echo "Error: qemu-img is not installed."
    exit 1
  fi
  qemu-img create -f qcow2 "$DISK_IMAGE" $DISK_SIZE || { echo "Failed to create disk image."; exit 1; }
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
