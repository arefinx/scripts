#!/bin/bash

# Telegram Bot API token
BOT_TOKEN="6429169464:AAE0lVM_q-lkpGJMgC1DPu2bcGqdCyn-1fg"

# Channel's chat ID
CHANNEL_ID="-1001898437654"

# File path
FILE_PATH="upload-link.txt"

# Using the Telegram Bot API to send the file to channel
curl -F "chat_id=$CHANNEL_ID" -F "document=@$FILE_PATH" "https://api.telegram.org/bot$BOT_TOKEN/sendDocument"

# Remove the file
rm -rf upload-link.txt

# Shutdown to save energy
sudo shutdown
