#!/bin/bash

# Skrip instalasi logo
curl -s https://raw.githubusercontent.com/choir94/Airdropguide/refs/heads/main/logo.sh | bash
sleep 5

# Perbarui sistem dan instal dependensi
sudo apt update && sudo apt install -y git nodejs npm screen

# Clone repository jika belum ada
if [ ! -d "Kaleido" ]; then
    git clone https://github.com/choir94/Kaleido.git
fi

# Masuk ke direktori proyek
cd Kaleido

# Instal dependensi
npm install

# Buat file wallets.txt jika belum ada
if [ ! -f "wallets.txt" ]; then
    echo "Masukkan alamat wallet satu per baris di wallets.txt"
    nano wallets.txt
fi

# Jalankan bot di dalam screen
screen -dmS kaleido-bot npm run start

echo "Bot sedang berjalan di dalam screen. Gunakan 'screen -r kaleido-bot' untuk melihat log."
