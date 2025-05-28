#!/bin/bash
#
# This script prepares a USB drive for Windows installation using WoeUSB.
# It prompts for the Windows ISO path and the target device, then installs WoeUSB
# and writes the ISO to the device with verbose debug output.

set -e

echo "=== WoeUSB Windows 10 USB Creator (Verbose Mode) ==="

# Prompt user for ISO path and target device
read -rp "Enter the path to your Windows 10 ISO file (e.g. /home/user/Downloads/Windows10.iso): " ISO_PATH
read -rp "Enter the target USB device path (e.g. /dev/sdb): " USB_DEVICE

#echo "=== Updating package lists ==="
#sudo apt update

#echo "=== Installing woeusb-ng ==="
#sudo apt install -y woeusb-ng

echo "=== Running WoeUSB with debug info ==="
set -x
sudo woeusb --device "$ISO_PATH" "$USB_DEVICE"
set +x

echo "=== Operation completed. Please reboot and select the USB device to install Windows. ==="
