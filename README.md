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

2. Ensure that the Dockerfiles are present:
   - `client/Dockerfile` for the frontend
   - `server/Dockerfile` for the backend

3. Run the setup script:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
   This script will:
   - Prompt you for your EC2 public IP address
   - Create the necessary `.env` file
   - Build and start the Docker containers using the existing Dockerfiles

4. Open the application in your browser:
   - Frontend: http://<YOUR_EC2_PUBLIC_IP>
   - Backend API: http://<YOUR_EC2_PUBLIC_IP>:8081

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

## Security Note

Running the frontend on port 80 (HTTP) is not secure for production use. For a production environment, you should set up HTTPS using a reverse proxy like Nginx and obtain an SSL/TLS certificate (e.g., using Let's Encrypt).
