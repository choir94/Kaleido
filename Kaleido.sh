#!/bin/bash

# Warna teks
CYAN='\033[1;36m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # Reset warna

echo -e "${CYAN}====================================="
echo -e "  Script Kaleido by airdrop node"
echo -e "=====================================${NC}"

# Periksa apakah curl sudah terinstal
echo -e "${CYAN}Memeriksa instalasi curl...${NC}"
if ! command -v curl &> /dev/null
then
    echo -e "${RED}curl belum terinstal!${NC}"
    echo -e "${CYAN}Menginstal curl...${NC}"
    
    # Instal curl
    apt install -y curl
    
    # Verifikasi instalasi curl
    if command -v curl &> /dev/null
    then
        echo -e "${GREEN}curl berhasil diinstal!${NC}"
    else
        echo -e "${RED}Gagal menginstal curl. Skrip dihentikan.${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}curl sudah terinstal!${NC}"
fi

# Periksa apakah Node.js sudah terinstal
echo -e "${CYAN}Memeriksa instalasi Node.js...${NC}"
if ! command -v node &> /dev/null
then
    echo -e "${RED}Node.js belum terinstal!${NC}"
    echo -e "${CYAN}Menginstal Node.js...${NC}"
    
    # Instal Node.js dan npm menggunakan NodeSource
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
    apt install -y nodejs
    
    # Verifikasi instalasi
    if command -v node &> /dev/null
    then
        echo -e "${GREEN}Node.js berhasil diinstal!${NC}"
    else
        echo -e "${RED}Gagal menginstal Node.js. Skrip dihentikan.${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}Node.js sudah terinstal!${NC}"
    echo -e "${CYAN}Memperbarui Node.js ke versi terbaru...${NC}"

    # Menginstal versi terbaru Node.js
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
    apt install -y nodejs

    # Verifikasi pembaruan
    NEW_VERSION=$(node -v)
    echo -e "${GREEN}Node.js telah diperbarui ke versi $NEW_VERSION${NC}"
fi

# Periksa apakah npm terinstal
echo -e "${CYAN}Memeriksa instalasi npm...${NC}"
if ! command -v npm &> /dev/null
then
    echo -e "${RED}npm belum terinstal!${NC}"
    echo -e "${CYAN}Menginstal npm menggunakan apt...${NC}"
    
    # Instal npm menggunakan apt
    apt install -y npm
    
    # Verifikasi instalasi npm
    if command -v npm &> /dev/null
    then
        echo -e "${GREEN}npm berhasil diinstal!${NC}"
    else
        echo -e "${RED}Gagal menginstal npm. Skrip dihentikan.${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}npm sudah terinstal!${NC}"
fi

# Klon repositori
echo -e "${CYAN}Mengkloning repositori...${NC}"
git clone https://github.com/choir94/Kaleido.git || { echo -e "${RED}Gagal mengkloning repositori!${NC}"; exit 1; }

# Beralih ke direktori yang dikloning
cd Kaleido || { echo -e "${RED}Gagal masuk ke direktori!${NC}"; exit 1; }

# Instal dependensi npm menggunakan apt
echo -e "${CYAN}Menginstal dependensi npm menggunakan apt...${NC}"
apt install -y npm || { echo -e "${RED}Gagal menginstal dependensi!${NC}"; exit 1; }

# Minta pengguna memasukkan alamat dompet
echo -e "${CYAN}Masukkan alamat dompet Anda (harus diawali dengan 0x):${NC}"
read -r wallet_address

# Periksa apakah alamat dompet valid
if [[ $wallet_address =~ ^0x[0-9a-fA-F]{40}$ ]]; then
    echo "$wallet_address" >> wallets.txt
    echo -e "${GREEN}Alamat dompet telah ditambahkan ke wallets.txt${NC}"
else
    echo -e "${RED}Kesalahan: Alamat dompet harus diawali dengan 0x dan memiliki 42 karakter.${NC}"
    exit 1
fi

# Jalankan bot di dalam screen
echo -e "${CYAN}Menjalankan bot di dalam screen...${NC}"
screen -dmS kaleido_bot bash -c "npm run start"

echo -e "${GREEN}Bot berhasil dijalankan di dalam screen!${NC}"
echo -e "${CYAN}Gunakan perintah berikut untuk masuk ke screen:${NC}"
echo -e "${GREEN}screen -r kaleido_bot${NC}"
echo -e "${CYAN}Tekan CTRL+A, lalu D untuk keluar dari screen tanpa menghentikan bot.${NC}"
