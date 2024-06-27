FROM amazonlinux:2

# Install dependencies
RUN yum install -y httpd zip unzip curl

# Add the zip file from the URL with a retry mechanism
RUN URL="https://github.com/mr-prantik/FriendNet/archive/refs/heads/main.zip" \
    && MAX_RETRIES=5 \
    && RETRY_DELAY=10 \
    && for i in $(seq 1 $MAX_RETRIES); do \
           curl -o /var/www/html/friendnet.zip $URL && break; \
           echo "Download failed, retrying in $RETRY_DELAY seconds..."; \
           sleep $RETRY_DELAY; \
       done \
    && if [ ! -f "/var/www/html/friendnet.zip" ]; then \
           echo "Failed to download after $MAX_RETRIES attempts"; \
           exit 1; \
       fi

# Set working directory
WORKDIR /var/www/html

# Unzip the downloaded file
RUN unzip friendnet.zip && rm -rf friendnet.zip

# Move contents to the correct location
RUN cp -rf FriendNet-main/* . && rm -rf FriendNet-main

# Expose port 80
EXPOSE 80

# Start httpd service
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
