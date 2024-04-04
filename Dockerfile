# Use PHP 8.0 CLI as base image
FROM php:8.3-cli

# Set working directory
WORKDIR /var/www/html

# Copy files from local folder to the Docker image
COPY ./UniFi-API-browser/* /var/www/html

# Update package list
RUN apt-get update

# Install git
RUN apt-get install -y git

# Install unzip
RUN apt-get install -y unzip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Run Composer install
RUN composer install

# Expose port 8000
EXPOSE 8000

# Start PHP built-in server
CMD ["php", "-S", "0.0.0.0:8000"]