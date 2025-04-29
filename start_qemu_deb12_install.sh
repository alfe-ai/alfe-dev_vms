#!/bin/bash

# This script boots a Debian 12 netinst ISO in QEMU for installation.
# Adjust paths and settings according to your environment.

ISO_PATH="/mnt/partition3/Downloads/debian-12.9.0-amd64-netinst.iso"
DISK_IMAGE="/mnt/partition3/debian_12_03012025.qcow2"

# Create a new disk image if needed (20GB example).
# qemu-img create -f qcow2 "$DISK_IMAGE" 20G

sudo qemu-system-x86_64 \
  -enable-kvm \
  -m 2G \
  -smp 2 \
  -boot d \
  -drive file="$DISK_IMAGE",format=qcow2 \
  -net nic \
  -net user,hostfwd=tcp::2224-:22

#-cdrom "$ISO_PATH"
