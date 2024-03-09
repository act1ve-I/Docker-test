FROM centos:8



ENV TZ=Asia/Dushanbe

RUN cd /etc/yum.repos.d/ \ 
  && sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
  && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN dnf update -y
RUN dnf install -y nginx php php-fpm php-mysqli
RUN dnf clean all
COPY nginx.conf /etc/nginx/
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN mkdir /run/php-fpm
RUN mkdir /opt/1

COPY ./1/ /opt/1/

COPY ./html/ /usr/share/nginx/html/

CMD php-fpm -D ; nginx
EXPOSE 80
