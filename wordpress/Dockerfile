FROM debian:bookworm

RUN apt update -y && apt install -y wget unzip nginx php php-curl php-fpm php-bcmath php-gd php-soap php-zip php-curl php-mbstring php-mysqlnd php-gd php-xml php-intl php-zip
RUN wget -P /var/www/html/ https://wordpress.org/latest.zip && unzip /var/www/html/latest.zip -d /var/www/html/ && rm /var/www/html/latest.zip
RUN chown -R www-data:www-data /var/www/html
RUN find /var/www/html -type d -exec chmod 755 {} \;
RUN find /var/www/html -type f -exec chmod 644 {} \;

COPY wp-config.php /var/www/html/wordpress/

COPY nginx.conf /etc/nginx/
COPY init.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init.sh 

EXPOSE 80
CMD ["/docker-entrypoint-initdb.d/init.sh"]
