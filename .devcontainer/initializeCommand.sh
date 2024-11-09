#!/bin/bash

# Define the paths for the history files
LOCAL_DEVCONTAINER_PATH="${HOME}/.devcontainer"
LOCAL_ZSH_HISTORY_PATH="${LOCAL_DEVCONTAINER_PATH}/zsh_history"
LOCAL_BASH_HISTORY_PATH="${LOCAL_DEVCONTAINER_PATH}/bash_history"

# Create the .devcontainer directory if it doesn't exist
if [ ! -d "$LOCAL_DEVCONTAINER_PATH" ]; then
    mkdir -p "$LOCAL_DEVCONTAINER_PATH"
    touch "$LOCAL_ZSH_HISTORY_PATH"
    touch "$LOCAL_BASH_HISTORY_PATH"
    echo "Created directory $LOCAL_DEVCONTAINER_PATH" and history files
else
    echo "Directory $LOCAL_DEVCONTAINER_PATH already exists"
fi