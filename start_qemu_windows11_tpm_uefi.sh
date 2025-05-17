#!/bin/bash

swtpm socket --tpm2 --tpmstate dir=/tmp/mytpm --ctrl type=unixio,path=/tmp/mytpm/swtpm-sock &
qemu-system-x86_64 \
  -enable-kvm \
  -m 4G \
  -cpu host \
  -drive file=windows11.qcow2,format=qcow2 \
  -cdrom Win11_24H2_English_x64.iso \
  -boot d \
  -chardev socket,id=chrtpm,path=/tmp/mytpm/swtpm-sock \
  -tpmdev emulator,id=tpm0,chardev=chrtpm \
  -device tpm-tis,tpmdev=tpm0 \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE.secboot.fd \
  -drive if=pflash,format=raw,file=/usr/share/OVMF/OVMF_VARS.fd
