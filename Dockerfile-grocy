FROM php:7.2-fpm-alpine
MAINTAINER Talmai Oliveira <to@talm.ai>

ENV REFRESHED_AT  2019-3-28
ENV GROCY_VERSION 2.2.0

RUN	apk update && \
	apk upgrade && \
	apk add --update yarn git wget &&\
	mkdir -p /www && \
    # Set environments
	sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /usr/local/etc/php-fpm.conf && \
	sed -i "s|;*listen\s*=\s*127.0.0.1:9000|listen = 9000|g" /usr/local/etc/php-fpm.conf && \
	sed -i "s|;*listen\s*=\s*/||g" /usr/local/etc/php-fpm.conf && \
#	sed -i "s|;*log_level\s*=\s*notice|log_level = debug|g" /usr/local/etc/php-fpm.conf && \
	sed -i "s|;*chdir\s*=\s*/var/www|chdir = /www|g" /usr/local/etc/php-fpm.d/www.conf && \
#	sed -i "s|;*access.log\s*=\s*log/\$pool.access.log|access.log = \$pool.access.log|g" /usr/local/etc/php-fpm.d/www.conf && \
#	sed -i "s|;*pm.status_path\s*=\s*/status|pm.status_path = /status|g" /usr/local/etc/php-fpm.d/www.conf && \
#	sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /usr/local/etc/php.ini && \
#    sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /usr/local/etc/php.ini && \
#    sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /usr/local/etc/php.ini && \
#    sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /usr/local/etc/php.ini && \
#    sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /usr/local/etc/php.ini && \
	wget https://raw.githubusercontent.com/composer/getcomposer.org/1b137f8bf6db3e79a38a5bc45324414a6b1f9df2/web/installer -O - -q | php -- --quiet && \
	mkdir -p /tmp/download && \
	cd /tmp/download && \
	wget -t 3 -T 30 -nv -O "grocy.zip" "https://github.com/grocy/grocy/archive/v${GROCY_VERSION}.zip" && \
	unzip grocy.zip && \
	rm -f grocy.zip && \
	cd grocy-${GROCY_VERSION} && \
	mv public /www/public && \
	mv controllers /www/controllers && \
	mv data /www/data && \
	mv helpers /www/helpers && \
	mv localization/ /www/localization && \
	mv middleware/ /www/middleware && \
	mv migrations/ /www/migrations && \
	mv publication_assets/ /www/publication_assets && \
	mv services/ /www/services && \
	mv views/ /www/views && \
	mv .yarnrc /www/ && \
	mv *.php /www/ && \
	mv *.json /www/ && \
	mv composer.* /root/.composer/ && \
	mv *yarn* /www/ && \
	mv *.sh /www/ && \
    # Cleaning up
    rm -rf /tmp/download && \
	rm -rf /var/cache/apk/*


# run php composer.phar with -vvv for extra debug information
RUN cd /var/www/html && \
	php composer.phar --working-dir=/www/ -n install && \
	cp /www/config-dist.php /www/data/config.php && \
	cd /www && \
	yarn install && \
	chown www-data:www-data -R /www/

# Set Workdir
WORKDIR /www/public

# Expose volumes
VOLUME ["/www"]

# Expose ports
EXPOSE 9000
