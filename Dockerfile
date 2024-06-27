FROM amazonlinux:2

# Install Apache HTTP Server and necessary tools
RUN yum install httpd zip unzip -y

# Download and extract your application from GitHub
ADD https://github.com/mr-prantik/FriendNet/archive/refs/heads/main.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip main.zip \
    && rm -rf main.zip \
    && mv FriendNet-main/* . \
    && rm -rf FriendNet-main

# Install Python if needed (assuming it's not included in your application)
# RUN yum install python3 -y

# Optional: Install additional dependencies for your application
# RUN pip install -r requirements.txt

# Set proper ownership and permissions for Apache to serve files
RUN chown -R apache:apache /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

# Configure Apache
COPY apache.conf /etc/httpd/conf.d/

# Expose port 80
EXPOSE 80

# Start Apache HTTP Server
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
