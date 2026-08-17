FROM php:8.2-apache

# Enable URL rewriting for .htaccess clean URLs
RUN a2enmod rewrite

COPY . /var/www/html/

EXPOSE 80

CMD ["apache2-foreground"]
