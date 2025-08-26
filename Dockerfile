FROM mautic/mautic:6-fpm
WORKDIR /var/www/html/
# Add the SendGrid API transport
RUN COMPOSER_ALLOW_SUPERUSER=1 composer require symfony/sendgrid-mailer --no-interaction --no-progress --ignore-platform-reqs --no-scripts
WORKDIR /var/www/html
RUN php bin/console cache:clear
RUN chown -R www-data:www-data /var/www/html/var
