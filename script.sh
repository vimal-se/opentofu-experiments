#!/bin/bash
    sudo su
    sudo yum update
    sudo yum install -y httpd
    sudo chkconfig httpd on
    sudo service httpd start
    echo "<h1>Deployed EC2 With OpenToFU</h1>" | sudo tee /var/www/html/index.html