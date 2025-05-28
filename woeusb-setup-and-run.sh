#!/usr/bin/env bash
set -euo pipefail

# woeusb-setup-and-run.sh — install WoeUSB-ng in a venv and create a Windows USB

## 1. Install system prerequisites
echo "=== Installing system packages ==="
sudo apt update
sudo apt install -y \
  python3-venv python3-pip python3-full \
  p7zip-full grub2-common grub-pc-bin \
  parted dosfstools ntfs-3g

## 2. Create or reuse the virtual environment
VENV_DIR="$HOME/woeusb-venv"
if [[ ! -d "$VENV_DIR" ]]; then
  echo "=== Creating Python virtual environment at $VENV_DIR ==="
  python3 -m venv "$VENV_DIR"
else
  echo "=== Using existing virtual environment at $VENV_DIR ==="
fi

## 3. Activate venv and install WoeUSB-ng (CLI only)
echo "=== Activating virtual environment ==="
# shellcheck disable=SC1090
source "$VENV_DIR/bin/activate"

echo "=== Upgrading pip and installing WoeUSB-ng[cli] ==="
pip install --upgrade pip
pip install WoeUSB-ng[cli]

## 4. Prompt for ISO path and target USB device
echo
read -r -p "Enter path to Windows ISO (e.g. ~/Downloads/Win10.iso): " ISO_PATH
read -r -p "Enter target USB device (e.g. /dev/sdb): " USB_DEVICE

## 5. Run WoeUSB to write the ISO
echo
echo "=== Running WoeUSB ==="
set -x
woeusb --device "$ISO_PATH" "$USB_DEVICE"
set +x

## 6. Clean up
echo
echo "=== Done! Bootable Windows USB created on $USB_DEVICE ==="
echo "When finished, deactivate the venv with:  deactivate"
