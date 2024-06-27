FROM amazonlinux:2

# Install dependencies
RUN yum install -y httpd

# Set working directory
WORKDIR /var/www/html

# Copy index.html from host to container
COPY index.html .

# Expose port 80
EXPOSE 80

# Start httpd service
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
