FROM amazonlinux:2

# Install dependencies
RUN yum install -y httpd git

# Clone the repository from GitHub
RUN git clone https://github.com/mr-prantik/FriendNet.git /var/www/html/FriendNet

# Set working directory
WORKDIR /var/www/html/FriendNet

# Move contents to the correct location
RUN cp -rf * /var/www/html/ && rm -rf /var/www/html/FriendNet

# Expose port 80
EXPOSE 80

# Start httpd service
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
