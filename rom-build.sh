#!/bin/bash

# Function to display colored text
print_message() {
    if [ "$2" == "success" ]; then
        echo -e "\e[32m$1\e[0m"  # Green color for success
    elif [ "$2" == "failure" ]; then
        echo -e "\e[31m$1\e[0m"  # Red color for failure
    else
        echo "$1"
    fi
}

# Prompt for device and branch
#read -p "Enter author: " AUTHOR
#read -p "Enter manufacturer: " MANUFACTURER
read -p "Enter device: " DEVICE
read -p "Enter branch: " BRANCH

# Define some stuff for now
AUTHOR=arefinx
MANUFACTURER=xiaomi

# Set repository paths
DD="device/$MANUFACTURER/$DEVICE"
KD="kernel/$MANUFACTURER/$DEVICE"
VD="vendor/$MANUFACTURER/$DEVICE"

# Clone device repository
print_message "Cloning device repository..." "info"
git clone "https://github.com/$AUTHOR/device_$MANUFACTURER_$DEVICE" -b "$BRANCH" "$DD"
if [ $? -eq 0 ]; then
    print_message "Device repository cloned successfully!" "success"
else
    print_message "Failed to clone device repository." "failure"
fi

# Clone kernel repository
print_message "Cloning kernel repository..." "info"
git clone "https://github.com/$AUTHOR/kernel_$MANUFACTURER_$DEVICE" -b thirteen "$KD"
if [ $? -eq 0 ]; then
    print_message "Kernel repository cloned successfully!" "success"
else
    print_message "Failed to clone kernel repository." "failure"
fi

# Clone vendor repository
print_message "Cloning vendor repository..." "info"
git clone "https://github.com/$AUTHOR/vendor_$MANUFACTURER_$DEVICE" -b thirteen "$VD"
if [ $? -eq 0 ]; then
    print_message "Vendor repository cloned successfully!" "success"
else
    print_message "Failed to clone vendor repository." "failure"
fi

# Clone required scripts
print_message "Cloning required scripts..." "info"
git clone https://github.com/arefinx/scripts scripts
if [ $? -eq 0 ]; then
    print_message "The scripts are cloned successfully!" "success"
else
    print_message "Failed to clone scripts." "failure"
fi

# Prompt for lunch codename and buildtype
read -p "Enter lunch command, i.e. aosp, lineage: " lunch_command
read -p "Enter build type: " build_type
read -p "Enter build command: " build_command

# Vendorsetup
source build/envsetup.sh

# Lunch command
lunch "$lunch_command"_"$DEVICE"-"$build_type"

# Build time
$build_command

# Build upload
bash scripts/upload.sh out/target/product/$DEVICE/*zip >>upload-link.txt
bash scripts/tg-upload.sh
