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

# Create frontend directory with a simple React app
mkdir -p frontend
cat > frontend/Dockerfile <<EOL
FROM node:14
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
EOL

# Create package.json for frontend
cat > frontend/package.json <<EOL
{
  "name": "frontend",
  "version": "1.0.0",
  "scripts": {
    "start": "react-scripts start"
  },
  "dependencies": {
    "react": "^17.0.2",
    "react-dom": "^17.0.2",
    "react-scripts": "4.0.3"
  },
  "browserslist": {
    "production": [
      ">0.2%",
      "not dead",
      "not op_mini all"
    ],
    "development": [
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ]
  }
}
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

# Create backend directory with a simple Express app
mkdir -p backend
cat > backend/Dockerfile <<EOL
FROM node:14
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
EXPOSE 5000
CMD ["node", "server.js"]
EOL

# Create package.json for backend
cat > backend/package.json <<EOL
{
  "name": "backend",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.17.1"
  }
}
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

echo "Simple frontend and backend applications created."

echo "Setup complete. You can now run 'docker-compose up --build' to start the application."