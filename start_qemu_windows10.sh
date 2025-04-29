#!/bin/bash

# This script starts a Windows 10 VM in QEMU with basic networking and graphics support.

DISK_IMAGE="/mnt/partition3/windows10.qcow2"

qemu-system-x86_64 \
  -enable-kvm \
  -cpu host \
  -m 4G \
  -vga virtio \
  -drive file="$DISK_IMAGE",format=qcow2 \
  -netdev user,id=net0 \
  -device e1000,netdev=net0 \
  -device virtio-balloon
