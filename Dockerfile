# Use Node.js Alpine base image
FROM node:16-alpine

# Create and set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package.json package-lock.json /app/

# Install dependencies
RUN npm install && npm install -g serve

# Copy the entire codebase to the working directory
COPY . /app/

# Build the application
RUN npm run build

# Expose the port your container app
EXPOSE 3000    

# command to start your application
CMD ["serve", "-s", "build", "-l", "3000"]
