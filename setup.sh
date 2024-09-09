#!/bin/bash

# Prompt for EC2 public IP
echo "Please enter your EC2 public IP address:"
read ec2_public_ip

# Create or update .env file
echo "EC2_PUBLIC_IP=$ec2_public_ip" > .env
echo "MONGO_URI=mongodb://mongo:27017/mern_social" >> .env

echo ".env file has been created/updated with the following content:"
cat .env

# Generate self-signed SSL certificate
echo "Generating self-signed SSL certificate..."
mkdir -p ./ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout ./ssl/nginx-selfsigned.key \
    -out ./ssl/nginx-selfsigned.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=$ec2_public_ip"

echo "SSL certificate generated successfully."

# Update docker-compose.yml to use HTTPS
sed -i 's/- "3000:3000"/- "443:3000"/' docker-compose.yml
sed -i 's/http:\/\/${EC2_PUBLIC_IP}:5000/https:\/\/${EC2_PUBLIC_IP}:5000/' docker-compose.yml
sed -i 's/http:\/\/${EC2_PUBLIC_IP}:3000/https:\/\/${EC2_PUBLIC_IP}:443/' docker-compose.yml

echo "docker-compose.yml updated to use HTTPS."

echo "Setup complete. You can now run 'docker-compose up --build' to start the application."