#! /bin/bash
# Install GitLab Server
curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
apt install jq -y
externalip=$(curl ifconfig.co)
sudo EXTERNAL_URL="http://$externalip" apt-get install gitlab-ce

# Install Docker
apt-get install docker.io -y

# Install GitLab Runner
sudo -E apt-get install gitlab-runner -y
