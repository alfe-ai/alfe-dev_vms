#!/bin/bash

# Create a new QEMU configuration file
cat << EOF > start_qemu_old_deb12.sh
#!/bin/bash

# Path to your preexisting qcow2 disk image
DISK_IMAGE="/mnt/partition7/debian_12_xfce.qcow2"

# Configuration options for the qemu-system command:
# -enable-kvm: Enables KVM virtualization
# -m 2G: Allocates 2 GB of RAM to the virtual machine
# -smp 2: Allocates 2 CPU cores to the virtual machine
# -drive format=qcow2,file=$DISK_IMAGE: Loads your preexisting disk image
qemu-system-x86_64 \
-enable-kvm \
-m 2G \
-smp 2 \
-drive format=qcow2,file=$DISK_IMAGE
EOF

# Apply execute permissions to the QEMU configuration file
chmod +x start_qemu_old_deb12.sh
