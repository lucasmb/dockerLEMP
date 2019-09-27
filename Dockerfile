FROM php:7.3-fpm
 

# Configura el directorio raiz
WORKDIR /var/www
 
# Instalamos dependencias
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    libzip-dev \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

# PHP Extensions
# RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl

RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
    && docker-php-ext-configure zip --with-libzip 

RUN docker-php-ext-install -j$(nproc) \
        gd \
        pdo_mysql \
        mbstring \
        zip \
        pcntl
 
# xdebug
RUN pecl install xdebug-2.7.0 \
    && docker-php-ext-enable xdebug

 # install node js
RUN rm -rf /var/lib/apt/lists/* && apt-get update
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get install -y nodejs

# Instalar composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Borramos cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# agregar usuario para la aplicación laravel
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www
 
# Copiar el directorio existente a /var/www
COPY ./ /var/www
 
# copiar los permisos del directorio de la aplicación
COPY --chown=www:www . /var/www
 
# cambiar el usuario actual por www
USER www
 
# exponer el puerto 9000 e iniciar php-fpm server
EXPOSE 9000
CMD ["php-fpm"] 
