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
read -p "Enter device: " DEVICE
read -p "Enter branch: " BRANCH

# Set repository paths
DD="device/xiaomi/$DEVICE"
KD="kernel/xiaomi/$DEVICE"
VD="vendor/xiaomi/$DEVICE"

# Clone device repository
print_message "Cloning device repository..." "info"
git clone "https://github.com/axsrog/device_xiaomi_$DEVICE" -b "$BRANCH" "$DD"
if [ $? -eq 0 ]; then
    print_message "Device repository cloned successfully!" "success"
else
    print_message "Failed to clone device repository." "failure"
fi

# Clone kernel repository
print_message "Cloning kernel repository..." "info"
git clone "https://github.com/axsrog/kernel_xiaomi_$DEVICE" -b "$BRANCH" "$KD"
if [ $? -eq 0 ]; then
    print_message "Kernel repository cloned successfully!" "success"
else
    print_message "Failed to clone kernel repository." "failure"
fi

# Clone vendor repository
print_message "Cloning vendor repository..." "info"
git clone "https://github.com/axsrog/vendor_xiaomi_$DEVICE" -b "$BRANCH" "$VD"
if [ $? -eq 0 ]; then
    print_message "Vendor repository cloned successfully!" "success"
else
    print_message "Failed to clone vendor repository." "failure"
fi

# Clone bionic repository if device is "lavender"
if [ "$DEVICE" == "lavender" ]; then
    print_message "Cloning bionic repository..." "info"
    git clone "https://github.com/axsrog/bionic"
    if [ $? -eq 0 ]; then
        print_message "Bionic repository cloned successfully!" "success"
    else
        print_message "Failed to clone bionic repository." "failure"
    fi
fi
