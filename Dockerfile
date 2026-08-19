FROM php:8.2-apache
 
# Fix for Railway's "AH00534: More than one MPM loaded" error.
# The php:8.2-apache base can end up with more than one Apache MPM
# (mpm_event / mpm_worker / mpm_prefork) enabled at once on Railway,
# which makes Apache refuse to start. mod_php requires mpm_prefork,
# so force that one on and make sure the others are off.
RUN a2dismod mpm_event mpm_worker 2>/dev/null || true \
    && a2enmod mpm_prefork
 
# Enable URL rewriting for .htaccess clean URLs
RUN a2enmod rewrite
 
COPY . /var/www/html/
EXPOSE 80
CMD ["apache2-foreground"]
