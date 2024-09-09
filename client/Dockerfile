# Use Node.js 13.12.0 as a base image
FROM node:13.12.0

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app
COPY . .

# Expose the frontend port for development
EXPOSE 3000

# Command to run the frontend
CMD ["npm", "start"]