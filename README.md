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

2. Build and start the Docker containers:
   ```bash
   docker-compose up --build
   ```

3. Open the application in your browser:
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:5000

4. MongoDB is running on port 27017. You can connect to it using MongoDB clients.

## Development

To run the application in development mode with live reloading:
