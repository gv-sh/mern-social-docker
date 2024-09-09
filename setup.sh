#!/bin/bash

# Prompt for EC2 public IP
echo "Please enter your EC2 public IP address:"
read ec2_public_ip

# Create or update .env file
echo "EC2_PUBLIC_IP=$ec2_public_ip" > .env
echo "MONGO_URI=mongodb://mongo:27017/mern_social" >> .env

echo ".env file has been created/updated with the following content:"
cat .env

# Check if Dockerfiles exist
if [ ! -f "client/Dockerfile" ]; then
    echo "Error: client/Dockerfile not found."
    exit 1
fi

if [ ! -f "server/Dockerfile" ]; then
    echo "Error: server/Dockerfile not found."
    exit 1
fi

# Build and start Docker containers
echo "Building and starting Docker containers..."
docker-compose up --build -d

echo "Setup complete. Your application should now be running."
echo "Frontend: http://$ec2_public_ip"
echo "Backend API: http://$ec2_public_ip:8081"