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

2. Run the setup script:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
   This script will:
   - Clean up Docker
   - Prompt you for your EC2 public IP address
   - Create the necessary `.env` file
   - Create placeholder frontend and backend directories

3. Build and start the Docker containers:
   ```bash
   docker-compose up --build
   ```

4. Open the application in your browser:
   - Frontend: http://<YOUR_EC2_PUBLIC_IP>:3000
   - Backend API: http://<YOUR_EC2_PUBLIC_IP>:5000

5. MongoDB is running on port 27017 (only accessible within the EC2 instance).

## Troubleshooting

If you encounter any issues, try the following steps:

1. Stop all running containers:
   ```bash
   docker-compose down
   ```

2. Remove all stopped containers, networks, and volumes:
   ```bash
   docker system prune -a
   ```

3. Remove all Docker volumes:
   ```bash
   docker volume prune
   ```

4. Run the setup script again:
   ```bash
   ./setup.sh
   ```

5. Rebuild and start the containers:
   ```bash
   docker-compose up --build
   ```

If problems persist, please check your Docker and Docker Compose versions and ensure they are up to date.
