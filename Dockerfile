# Step 1: Use Node.js to build the Angular application
FROM node:18 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json files
COPY . /app

# Install dependencies
RUN npm install

# Copy the Angular project files
COPY . .

# Build the Angular app for production
RUN npm run build -- --configuration production

# Step 2: Use Nginx to serve the Angular application
FROM nginx:stable-alpine

# Copy the built files from the previous stage
COPY --from=build /app/dist/dental-clinic-frontend /usr/share/nginx/html

# Expose the default Nginx HTTP port
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
