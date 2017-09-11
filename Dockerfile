FROM ubuntu:17.04

RUN echo 'deb http://ftp.gwdg.de/pub/misc/cran/bin/linux/ubuntu zesty/' >> /etc/apt/sources.list

RUN apt-get -y update && apt-get install -y --allow-unauthenticated \
   apache2 \
   cron \
   curl \
   less \
   libapache2-mod-perl2 \
   libapache2-mod-php \
   libcairo2-dev \
   libxt-dev \
   nano \
   p7zip \
   php \
   php-curl \
   php-gd \
   php-mbstring \
   php-mcrypt \
   php-mysql \
   php-xml \
   php-xmlrpc \
   r-base \
   r-base-dev \
   wget

RUN Rscript -e "install.packages(c('FastRWeb', 'Rserve'), repos = 'http://ftp.gwdg.de/pub/misc/cran')" 

WORKDIR /usr/local/lib/R/site-library/FastRWeb
RUN ./install.sh \
   chown -R www-data:www-data /var/FastRWeb

WORKDIR /var/www

RUN cp /usr/local/lib/R/site-library/FastRWeb/cgi-bin/Rcgi /usr/lib/cgi-bin/R

RUN cp /etc/apache2/conf-available/security.conf /etc/apache2/conf-available/security_old.conf; \
   cat /etc/apache2/conf-available/security.conf | sed -e 's#ServerTokens OS#ServerTokens Prod#g' -e 's#ServerSignature On#ServerSignature Off#g' > security.conf; \
   cat /etc/apache2/apache2.conf | sed "s#Timeout 300#Timeout 30#g" > apache2.conf; \
   mv apache2.conf /etc/apache2/apache2.conf; \
   mv security.conf /etc/apache2/conf-available/security.conf

COPY helper/fastrweb-configure /usr/bin/
COPY helper/fastrweb-cgi.conf /etc/apache2/sites-available/

RUN chmod 700 /usr/bin/fastrweb-configure; \
   chmod -R 755 /usr/lib/cgi-bin

ENTRYPOINT ["fastrweb-configure"]

   




