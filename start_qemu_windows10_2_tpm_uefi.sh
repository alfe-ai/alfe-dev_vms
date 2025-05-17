#!/bin/bash

STATE_DIR=/tmp/mytpm
# Ensure TPM state directory exists
mkdir -p "$STATE_DIR"

# Start the TPM emulator
swtpm socket \
  --tpm2 \
  --tpmstate dir="$STATE_DIR" \
  --ctrl type=unixio,path="$STATE_DIR/swtpm-sock" &

# Give swtpm a moment to create its socket
sleep 1

# Launch QEMU with TPM+UEFI
qemu-system-x86_64 \
  -enable-kvm \
  -m 4G \
  -cpu host \
  -drive file=/mnt/part7/windows10_051725.qcow2,format=qcow2 \
  -cdrom "$1" \
  -boot d \
  -chardev socket,id=chrtpm,path="$STATE_DIR/swtpm-sock" \
  -tpmdev emulator,id=tpm0,chardev=chrtpm \
  -device tpm-tis,tpmdev=tpm0 \
  # UEFI firmware: CODE and VARS must match your /usr/share/OVMF filenames
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd \
  -drive if=pflash,format=raw,file=/usr/share/OVMF/OVMF_VARS_4M.fd
