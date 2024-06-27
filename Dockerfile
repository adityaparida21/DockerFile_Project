FROM amazonlinux:2

# Install dependencies
RUN yum install -y httpd zip unzip curl

# Add the zip file from the URL with a retry mechanism
RUN URL="https://www.free-css.com/assets/files/free-css-templates/download/page296/spering.zip" \
    && MAX_RETRIES=5 \
    && RETRY_DELAY=10 \
    && for i in $(seq 1 $MAX_RETRIES); do \
           curl -o /var/www/html/spering.zip $URL && break; \
           echo "Download failed, retrying in $RETRY_DELAY seconds..."; \
           sleep $RETRY_DELAY; \
       done \
    && if [ ! -f "/var/www/html/spering.zip" ]; then \
           echo "Failed to download after $MAX_RETRIES attempts"; \
           exit 1; \
       fi

# Set working directory
WORKDIR /var/www/html

# Unzip the downloaded file
RUN unzip spering.zip && rm -rf spering.zip

# Move contents to the correct location
RUN cp -rf spering-html/* . && rm -rf spering-html

# Expose port 80
EXPOSE 80

# Start httpd service
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
