FROM amazonlinux:2 
RUN yum install httpd zip unzip -y
ADD https://github.com/mr-prantik/FriendNet/archive/refs/heads/main.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip main.zip
RUN rm -rf main.zip
RUN  cp -rf FriendNet-main/* .
RUN  rm -rf FriendNet-main 
EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
