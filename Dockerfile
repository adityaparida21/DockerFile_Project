FROM amazonlinux:2 
RUN yum install httpd zip unzip -y
ADD https://www.free-css.com/assets/files/free-css-templates/download/page296/spering.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip spering.zip
RUN rm -rf spering.zip
RUN  cp -rf spering-html/* .
RUN  rm -rf spering-html 
EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

