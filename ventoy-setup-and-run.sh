#!/usr/bin/env bash
set -euo pipefail

# ventoy-setup-and-run.sh — install Ventoy on a USB stick and copy an ISO

echo "=== Ventoy USB Creator ==="

# 1. Install prerequisites
echo "Installing system packages..."
sudo apt update
sudo apt install -y wget tar

# 2. Ask for Ventoy version and download URL
read -rp "Enter Ventoy version (e.g. 1.0.90): " VENTOY_VER
TARBALL="ventoy-${VENTOY_VER}-linux.tar.gz"
URL="https://github.com/ventoy/Ventoy/releases/download/v${VENTOY_VER}/${TARBALL}"

echo "Downloading Ventoy ${VENTOY_VER}..."
wget -qO "/tmp/${TARBALL}" "${URL}"

# 3. Extract Ventoy
echo "Extracting Ventoy package..."
tar -xzf "/tmp/${TARBALL}" -C /tmp

# 4. Prompt for USB device and install Ventoy
read -rp "Enter target USB device (e.g. /dev/sdb): " USB_DEV
echo "⚠️  All data on ${USB_DEV} will be erased!"
read -rp "Proceed with installation? [y/N]: " CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
  echo "Aborted."
  exit 1
fi

echo "Installing Ventoy to ${USB_DEV}..."
sudo sh "/tmp/ventoy-${VENTOY_VER}/Ventoy2Disk.sh" -i "${USB_DEV}"

# 5. Prompt for ISO and copy to Ventoy partition
read -rp "Enter path to Windows ISO (e.g. ~/Downloads/Win10.iso): " ISO_PATH
MNT="/mnt/ventoy_tmp"
echo "Copying ISO to USB..."
sudo mkdir -p "${MNT}"
sudo mount "${USB_DEV}1" "${MNT}"
sudo cp -v "${ISO_PATH}" "${MNT}/"
sync
sudo umount "${MNT}"
sudo rmdir "${MNT}"

echo "=== Done! Ventoy is installed on ${USB_DEV} and ${ISO_PATH} has been copied. ==="
