FROM johanneselias/ubuntu1704-apache2-php-perl:1.0

RUN echo 'deb http://ftp.gwdg.de/pub/misc/cran/bin/linux/ubuntu zesty/' >> /etc/apt/sources.list

RUN apt-get -y update && apt-get install -y --allow-unauthenticated \
   libcairo2-dev \
   r-base \
   r-base-dev 

RUN Rscript -e "install.packages(c('FastRWeb', 'Rserve'), repos = 'http://ftp.gwdg.de/pub/misc/cran')" 

WORKDIR /usr/local/lib/R/site-library/FastRWeb
RUN ./install.sh \
   chown -R www-data:www-data /var/FastRWeb

WORKDIR /var/www

RUN cp /usr/local/lib/R/site-library/FastRWeb/cgi-bin/Rcgi /usr/lib/cgi-bin/R

COPY helper/fastrweb-configure /usr/bin/
COPY helper/fastrweb-cgi.conf /etc/apache2/sites-available/

RUN chmod 700 /usr/bin/fastrweb-configure; \
   chmod -R 755 /usr/lib/cgi-bin

ENTRYPOINT ["fastrweb-configure"]
   




