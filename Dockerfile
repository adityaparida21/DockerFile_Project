FROM amazonlinux:2

# Install necessary packages
RUN yum install httpd zip unzip -y

# Download and extract your application
ADD https://github.com/mr-prantik/FriendNet/archive/refs/heads/main.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip main.zip && \
    rm -rf main.zip

# Copy contents from extracted directory
RUN mv FriendNet-main/* . && \
    rm -rf FriendNet-main

# Expose port and start Apache
EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
