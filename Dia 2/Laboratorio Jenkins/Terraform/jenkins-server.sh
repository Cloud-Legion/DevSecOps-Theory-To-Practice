#! /bin/bash
# Install Jenkins
sudo apt update -y
sudo apt install openjdk-8-jdk -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y

# Install Hugo
wget https://github.com/gohugoio/hugo/releases/download/v0.83.1/hugo_0.83.1_Linux-64bit.deb
dpkg -i hugo_0.83.1_Linux-64bit.deb

# Install Nginx Web Server
apt-get install nginx -y

# Fixed permissions
chmod 777 -R /tmp
echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


