#! /bin/bash
# Install GitLab Server
curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
apt install jq -y
externalip=$(curl ifconfig.co)
sudo EXTERNAL_URL="http://$externalip" apt-get install gitlab-ee
