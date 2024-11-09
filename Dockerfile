# Base image
FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Build arguments
ARG USERNAME
ARG USER_UID
ARG USER_GID

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary tools and basic dependencies, including sudo
RUN apt-get update && apt-get install -y \
    sudo \
    build-essential \
    curl \
    git \
    wget \
    zsh \
    locate \
    v4l-utils \
    x11-apps \
    && rm -rf /var/lib/apt/lists/*

# Modify the 'vscode' user and group to match the host user
RUN usermod --login $USERNAME vscode \
    && groupmod --new-name $USERNAME vscode \
    && usermod --home /home/$USERNAME -m $USERNAME

# If UID/GID do not match, adjust them
RUN if [ "$(id -u $USERNAME)" != "$USER_UID" ]; then usermod --uid $USER_UID $USERNAME; fi \
    && if [ "$(id -g $USERNAME)" != "$USER_GID" ]; then groupmod --gid $USER_GID $USERNAME; fi

# Add user to sudoers with no password requirement
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Set the default user
USER $USERNAME
WORKDIR /home/$USERNAME/workspace

# Ensure the workspace directory exists and has correct permissions
RUN mkdir -p /home/$USERNAME/workspace \
    && chown -R $USERNAME:$USERNAME /home/$USERNAME/workspace

# Copy the current directory contents into the container working directory
COPY . /home/$USERNAME/workspace

# Set the shell
ENV SHELL /bin/bash
SHELL ["/bin/bash", "-c"]
