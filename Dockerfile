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

# # Nginx setup
# FROM nginx:alpine
# COPY --from=build /app/build /usr/share/nginx/html
# EXPOSE 6000


# Nginx setup
FROM nginx:alpine
# Remove the default nginx configuration that comes with the image
RUN rm /etc/nginx/conf.d/default.conf
# Copy the custom nginx configuration file into the image
COPY /etc/nginx/nginx.conf /etc/nginx/nginx.conf
# Copy the static build directory from the build stage into the Nginx image
COPY --from=build /app/build /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]