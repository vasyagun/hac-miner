#!/bin/bash

# 1. Установка зависимостей
echo "Обновление системы и установка зависимостей..."
sudo apt-get update && sudo apt-get install -y \
    build-essential \
    autoconf \
    libtool \
    libcurl4-openssl-dev \
    libjansson-dev \
    libssl-dev \
    libgmp-dev \
    libudev-dev \
    libusb-1.0-0-dev

# 2. Скачивание и распаковка майнера
echo "Скачивание майнера..."
cd /root
wget -O hacash_miner.zip "https://github.com/vasyagun/gpool/releases/download/hac-miner/HAC_GPU_Miner.for.ubuntu24.04.0313.zip"
unzip -o hacash_miner.zip -d hacash_miner
cd hacash_miner

# 3. Установка прав на выполнение
echo "Настройка прав доступа..."
chmod +x ccminer

# 4. Установка переменной среды
echo "Настройка LD_LIBRARY_PATH..."
export LD_LIBRARY_PATH=/root/hacash_miner:$LD_LIBRARY_PATH
echo 'export LD_LIBRARY_PATH=/root/hacash_miner:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc

# 5. Запуск майнера в screen
echo "Запуск майнера в screen..."
screen -S hac_miner -dm bash -c './ccminer -a x16rs -o stratum+tcp://hac.43.130.38.179:3333 -u 1KKtRHd37a9SYeKtAqFRmvQqTcMbiJVUDy -p x'
echo "Майнер запущен! Чтобы посмотреть процесс, введите: screen -r hac_miner"
