#!/bin/bash
# Configure Nginx for React SPA
cat > /etc/nginx/conf.d/react-app.conf << 'EOL'
server {
    listen 80;
    server_name _;
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
    
    # Handle static assets
    location /static/ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
EOL

# Remove default config if it exists
if [ -f /etc/nginx/conf.d/default.conf ]; then
  rm -f /etc/nginx/conf.d/default.conf
fi

# Remove default nginx config
if [ -f /etc/nginx/nginx.conf.default ]; then
  rm -f /etc/nginx/nginx.conf.default
fi

# Set proper permissions
chmod -R 755 /usr/share/nginx/html
chown -R nginx:nginx /usr/share/nginx/html

# Test nginx configuration
nginx -t

# Restart nginx
systemctl restart nginx
systemctl enable nginx

echo "After install completed successfully"
