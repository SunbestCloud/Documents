#Create a logical volume and extend the volume group
#!/bin/bash

# Set the name of the volume group to extend
VG_NAME="vg01"

# Set the name of the logical volume to create
LV_NAME="lv01"

# Set the size of the logical volume to create
LV_SIZE="10G"

# Set the path of the physical volume to add
PV_PATH="/dev/sdc1"

# Create the logical volume
lvcreate -L "${LV_SIZE}" -n "${LV_NAME}" "${VG_NAME}"

# Resize the physical volume to use all available space
pvresize "${PV_PATH}"

# Extend the volume group to include the new physical volume
vgextend "${VG_NAME}" "${PV_PATH}"

# Extend the logical volume to include the additional space
lvextend -r -l +100%FREE "/dev/${VG_NAME}/${LV_NAME}"
