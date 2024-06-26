FROM centos:8-stream
RUN yum install httpd zip unzip -y
ADD https://github.com/mr-prantik/FriendNet/archive/refs/heads/main.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip main.zip
RUN rm -rf main.zip
RUN cp -rf main-html/* .
RUN rm -rf main-html
EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
