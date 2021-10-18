#! /bin/bash
# Install GitLab Server
curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
apt install jq -y
externalip=$(curl ifconfig.co)
sudo EXTERNAL_URL="http://$externalip" GITLAB_ROOT_PASSWORD= apt-get install gitlab-ee
