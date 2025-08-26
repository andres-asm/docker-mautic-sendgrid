# Dockerfile
ARG BASE_TAG=6-fpm
FROM mautic/mautic:${BASE_TAG}

WORKDIR /var/www/html

# Add the SendGrid API transport (skip scripts; avoids needing node)
RUN COMPOSER_ALLOW_SUPERUSER=1 \
    composer require symfony/sendgrid-mailer --no-interaction --no-progress --ignore-platform-reqs --no-scripts

# Optional but recommended if you ever see "unknown DSN" again:
# RUN COMPOSER_ALLOW_SUPERUSER=1 \
#     composer require symfony/http-client:^7 --no-interaction --no-progress --ignore-platform-reqs --no-scripts

RUN php bin/console cache:clear --no-warmup && rm -rf var/cache/prod
RUN chown -Rc www-data:www-data /var/www/html/var
