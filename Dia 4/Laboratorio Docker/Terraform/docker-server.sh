#! /bin/bash

# Install Docker
apt-get update 
apt-get install docker.io -y

# Install GitLab Runner
curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb"
dpkg -i gitlab-runner_amd64.deb
sudo usermod -aG docker gitlab-runner
service gitlab-runner restart