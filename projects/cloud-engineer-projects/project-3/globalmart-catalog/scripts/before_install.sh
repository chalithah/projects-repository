#!/bin/bash
# Install nginx if not present
if ! command -v nginx &> /dev/null; then
    echo "Installing nginx..."
    yum update -y
    yum install -y nginx
fi

# Ensure nginx is enabled and started
systemctl enable nginx
systemctl start nginx

# Ensure deployment directory exists and clean it
if [ ! -d /usr/share/nginx/html ]; then
  mkdir -p /usr/share/nginx/html
fi
rm -rf /usr/share/nginx/html/*

echo "Before install completed successfully"
