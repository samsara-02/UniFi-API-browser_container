# Use PHP 8.0 CLI as base image
FROM php:8.3-cli-alpine

# Set working directory
WORKDIR /var/www/html

# Copy files from local folder to the Docker image
COPY ./UniFi-API-browser /var/www/html

# Update package list and install dependencies
RUN apk update && apk add git unzip gettext

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Run Composer install
RUN composer install

# Copy and rename the config file
RUN cp config/config-template.php config/config.php

# Replace placeholders with environment variables
RUN envsubst < config/config-template.php > config/config.php

# Expose port 80
EXPOSE 80

# Start PHP built-in server
CMD ["php", "-S", "0.0.0.0:80"]