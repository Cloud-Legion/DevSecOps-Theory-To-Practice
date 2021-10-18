#! /bin/bash
# Install GitLab Server
curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
apt install jq -y
externalip=$(curl ifconfig.co)
sudo EXTERNAL_URL="http://$externalip" GITLAB_ROOT_PASSWORD=Password1234! apt-get install gitlab-ce

# Install Docker
apt-get install docker.io -y

# Install GitLab Runner
curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb"
dpkg -i gitlab-runner_amd64.deb
sudo usermod -aG docker gitlab-runner
service gitlab-runner restart
