FROM centos
RUN yum update -y
RUN yum install -y openssh-server wget unzip gcc make python-setuptools vim pcre-devel libxml2-devel autoconf
RUN yum install -y tar bzip2 apr-devel apr-util-devel ; true
RUN yum clean all
RUN easy_install supervisor

# apache
RUN cd /tmp && wget http://ftp.kddilabs.jp/infosystems/apache//httpd/httpd-2.4.10.tar.bz2
RUN cd /tmp && tar jxvf httpd-2.4.10.tar.bz2
RUN cd /tmp/httpd-2.4.10 && ./configure --enable-so && make &&make install
RUN echo "みんなーっ！ご飯炊けたよっ♪" > /usr/local/apache2/htdocs/index.html
RUN echo "AddType application/x-httpd-php .php" >> /usr/local/apache2/conf/httpd.conf
RUN echo "LoadModule php5_module modules/libphp5.so" >> /usr/local/apache2/conf/httpd.conf
ADD redis.php /usr/local/apache2/htdocs/redis.php

# php
RUN cd /tmp && wget http://jp2.php.net/distributions/php-5.5.15.tar.gz && tar zvxf php-5.5.15.tar.gz && cd php-5.5.15/ && ./configure  --with-apxs2=/usr/local/apache2/bin/apxs && make && make install

# phpredis
RUN cd /tmp && wget https://github.com/nicolasff/phpredis/archive/master.zip
RUN cd /tmp && unzip master.zip && cd /tmp/phpredis-master && phpize && ./configure && make && make install
RUN echo "extension=redis.so" >> /usr/local/lib/php.ini
RUN sed -i -e "s|;date.timezone =|date.timezone = Asia/Tokyo|" /usr/local/lib/php.ini

# SSH
ADD id_rsa.pub /root/id_rsa.pub
RUN mkdir -p /root/.ssh/ /var/run/sshd
RUN cp /root/id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys
RUN /usr/bin/ssh-keygen -t rsa  -f /etc/ssh/ssh_host_rsa_key -N ''
RUN /usr/bin/ssh-keygen -t ecdsa  -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN sed -i -e 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# supervisor
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisord.conf
EXPOSE 22 80
CMD ["/usr/bin/supervisord"]
