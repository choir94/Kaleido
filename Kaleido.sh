#!/bin/bash

# Warna teks
CYAN='\033[1;36m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # Reset warna

echo -e "${CYAN}====================================="
echo -e "  Script Kaleido by airdrop node"
echo -e "=====================================${NC}"

# Klon repositori
echo -e "${CYAN}Mengkloning repositori...${NC}"
git clone https://github.com/choir94/Kaleido.git || { echo -e "${RED}Gagal mengkloning repositori!${NC}"; exit 1; }

# Beralih ke direktori yang dikloning
cd Kaleido || { echo -e "${RED}Gagal masuk ke direktori!${NC}"; exit 1; }

# Instal dependensi npm
echo -e "${CYAN}Menginstal dependensi...${NC}"
npm install || { echo -e "${RED}Gagal menginstal dependensi!${NC}"; exit 1; }

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
