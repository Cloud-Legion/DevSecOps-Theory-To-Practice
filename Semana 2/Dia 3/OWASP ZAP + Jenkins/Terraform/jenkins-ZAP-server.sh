#! /bin/bash
# Install Jenkins
sudo apt update -y
sudo apt install openjdk-8-jdk -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y

# Fixed permissions
chmod 777 -R /tmp
echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Install Docker 
apt-get install docker.io -y

# Install Python + pip
apt install python3-pip -y


