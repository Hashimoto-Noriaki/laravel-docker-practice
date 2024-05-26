# ベースイメージ
FROM php:8.1-fpm

# 作業ディレクトリの設定
WORKDIR /var/www

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl

# PHP拡張機能のインストール
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Composerのインストール
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# アプリケーションコードのコピー
COPY . /var/www

# 許可の設定
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www

# スタートアップコマンド
CMD ["php-fpm"]
