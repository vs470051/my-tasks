
#!/bin/bash


until ping -c1 8.8.8.8 &>/dev/null; do :; done
sudo yum update -y
sudo systemctl start httpd
sudo systemctl enable httpd