#!/bin/bash

# Prompt for EC2 public IP
echo "Please enter your EC2 public IP address:"
read ec2_public_ip

# Create or update .env file
echo "EC2_PUBLIC_IP=$ec2_public_ip" > .env
echo "MONGO_URI=mongodb://mongo:27017/mern_social" >> .env

echo ".env file has been created/updated with the following content:"
cat .env

# Create frontend directory with placeholder Dockerfile and files
mkdir -p frontend
cat > frontend/Dockerfile <<EOL
FROM node:14
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
EOL

echo '{"name":"frontend","version":"1.0.0","scripts":{"start":"echo \"Frontend placeholder\" && sleep infinity"}}' > frontend/package.json

# Create backend directory with placeholder Dockerfile and files
mkdir -p backend
cat > backend/Dockerfile <<EOL
FROM node:14
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 5000
CMD ["npm", "start"]
EOL

echo '{"name":"backend","version":"1.0.0","scripts":{"start":"echo \"Backend placeholder\" && sleep infinity"}}' > backend/package.json

echo "Placeholder frontend and backend directories created."

echo "Setup complete. You can now run 'docker-compose up --build' to start the application."