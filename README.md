# MERN Social Dockerized

This project is a Dockerized version of a MERN social media app. It uses MongoDB for data storage, Express and Node.js for the backend API, and React for the frontend user interface.

## Requirements

- Docker
- Docker Compose

## Setup Instructions

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/mern-social-docker.git
   cd mern-social-docker
   ```

2. Create a `.env` file in the root directory and add your EC2 public IP:
   ```
   EC2_PUBLIC_IP=your_ec2_public_ip_here
   ```

3. Update the `docker-compose.yml` file to use the environment variable:
   ```yaml
   version: '3'
   services:
     frontend:
       environment:
         - REACT_APP_API_URL=http://${EC2_PUBLIC_IP}:5000
     backend:
       environment:
         - CORS_ORIGIN=http://${EC2_PUBLIC_IP}:3000
   ```

4. Build and start the Docker containers:
   ```bash
   docker-compose up --build
   ```

5. Open the application in your browser:
   - Frontend: http://<YOUR_EC2_PUBLIC_IP>:3000
   - Backend API: http://<YOUR_EC2_PUBLIC_IP>:5000

6. MongoDB is running on port 27017 (only accessible within the EC2 instance).

## Setting up Nginx Proxy

1. Install Nginx on your EC2 instance:
   ```bash
   sudo apt update
   sudo apt install nginx
   ```

2. Create a new Nginx configuration file:
   ```bash
   sudo nano /etc/nginx/sites-available/mern-social
   ```

3. Add the following configuration:
   ```nginx
   server {
       listen 80;
       server_name your_domain.com;

       location / {
           proxy_pass http://localhost:3000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }

       location /api {
           proxy_pass http://localhost:5000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }
   }
   ```

4. Create a symbolic link to enable the site:
   ```bash
   sudo ln -s /etc/nginx/sites-available/mern-social /etc/nginx/sites-enabled
   ```

5. Test the Nginx configuration:
   ```bash
   sudo nginx -t
   ```

6. If the test is successful, restart Nginx:
   ```bash
   sudo systemctl restart nginx
   ```

7. Update your application to use the new URLs:
   - Frontend: http://your_domain.com
   - Backend API: http://your_domain.com/api

Remember to replace `your_domain.com` with your actual domain name or EC2 public IP address.
