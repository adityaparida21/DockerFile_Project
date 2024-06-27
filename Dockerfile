FROM amazonlinux:2

# Install dependencies
RUN yum install -y httpd git

# Set working directory
WORKDIR /var/www/html

# Clone the GitHub repository
RUN git clone https://github.com/mr-prantik/FriendNet.git .

# Clean up any unnecessary files if needed
RUN rm -rf .git

# Expose port 80
EXPOSE 80

# Start httpd service
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
