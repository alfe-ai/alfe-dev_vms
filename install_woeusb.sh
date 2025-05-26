#!/usr/bin/env bash
set -euo pipefail

# install_woeusb.sh — set up WoeUSB-ng in a Python venv

# 1. Ensure APT is up to date and install prerequisites
sudo apt update
sudo apt install -y python3-venv python3-pip python3-full git p7zip-full grub2-common grub-pc-bin parted dosfstools ntfs-3g

# 2. Create the virtual environment if it doesn't exist
VENV_DIR="$HOME/woeusb-venv"
if [[ ! -d "$VENV_DIR" ]]; then
  python3 -m venv "$VENV_DIR"
  echo "Created virtual environment at $VENV_DIR"
else
  echo "Using existing virtual environment at $VENV_DIR"
fi

# 3. Activate and install WoeUSB-ng
source "$VENV_DIR/bin/activate"
pip install --upgrade pip
pip install WoeUSB-ng

# 4. Verify installation
echo
echo "Installed WoeUSB at: $(which woeusb)"
echo

# 5. Usage instructions
cat <<EOF
To use WoeUSB-ng, first activate the venv:
  source "$VENV_DIR/bin/activate"

Then run:
  woeusb --device /path/to/Windows10.iso /dev/sdX

When finished, deactivate:
  deactivate
EOF
