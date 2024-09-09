#!/bin/bash

# Clean up Docker
echo "Cleaning up Docker..."
docker-compose down -v
docker system prune -af
docker volume prune -f

# Prompt for EC2 public IP
echo "Please enter your EC2 public IP address:"
read ec2_public_ip

# Create or update .env file
echo "EC2_PUBLIC_IP=$ec2_public_ip" > .env
echo "MONGO_URI=mongodb://mongo:27017/mern_social" >> .env

echo ".env file has been created/updated with the following content:"
cat .env

# Copy the package.json from the root of the repo
cp package.json ./package.json

# Create frontend directory
mkdir -p frontend/src frontend/public
cat > frontend/Dockerfile <<EOL
FROM node:14
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "run", "start:frontend"]
EOL

cat > frontend/src/index.js <<EOL
import React from 'react';
import ReactDOM from 'react-dom';

ReactDOM.render(
  <h1>Hello from Frontend!</h1>,
  document.getElementById('root')
);
EOL

cat > frontend/public/index.html <<EOL
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MERN Social Frontend</title>
</head>
<body>
    <div id="root"></div>
</body>
</html>
EOL

# Create backend directory
mkdir -p backend
cat > backend/Dockerfile <<EOL
FROM node:14
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
EXPOSE 5000
CMD ["npm", "run", "start:backend"]
EOL

cat > backend/server.js <<EOL
const express = require('express');
const app = express();
const port = 5000;

app.get('/', (req, res) => {
  res.send('Hello from Backend!');
});

app.listen(port, () => {
  console.log(\`Backend server running at http://localhost:\${port}\`);
});
EOL

echo "Frontend and backend directories created with shared package.json."

echo "Setup complete. You can now run 'docker-compose up --build' to start the application."