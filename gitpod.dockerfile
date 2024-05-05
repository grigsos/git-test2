FROM gitpod/workspace-python-3.12

USER gitpod

# Install necessary tools
RUN sudo apt-get update && \
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    sudo apt-get update && \
    sudo apt-get install -y docker-ce

# Add Gitpod user to the Docker group
RUN sudo usermod -aG docker gitpod

# Install Python development tools
RUN sudo apt-get install -y python3-pip
RUN pip3 install flake8 pytest

# Install GitHub CLI using official instructions
# Start from a base image that has apt package manager, such as Ubuntu
FROM ubuntu:latest

# Set environment variables to non-interactive (to avoid tzdata prompts)
ENV DEBIAN_FRONTEND=noninteractive

# Run the commands to install wget and GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    sudo apt update \
    sudo apt install gh

# Command to run when starting the container
CMD ["bash"]

