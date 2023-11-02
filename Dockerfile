# # Use an official Node.js runtime as a base image
# FROM node:16

# # Set the working directory in the container
# WORKDIR /app

# # Copy the package.json and package-lock.json files
# COPY package*.json ./

# # Install application dependencies
# RUN npm install

# # Copy the remaining application code
# COPY . .

# # Build the React app
# RUN npm run build

# # Expose a port (e.g., 80)
# EXPOSE 3000

# # Start the React app
# CMD ["npm", "start"]

# Build the application
FROM node:16 AS build
WORKDIR /app
COPY package*.json ./

# # Install application dependencies
RUN npm install

# # Copy the remaining application code
COPY . .

# # Build the React app
RUN npm run build

# Nginx setup
FROM nginx:alpine
# Copy the custom nginx config
COPY ./etc/nginx/sites-available/default /etc/nginx/sites-available/

COPY --from=build /app/build /usr/share/nginx/html


EXPOSE 6000
CMD ["nginx", "-g", "daemon off;"]