#!/bin/bash

# Clone repository
git clone https://github.com/choir94/Kaleido.git

# Berpindah ke direktori hasil clone
cd Kaleido

# Install dependensi npm
npm install

# Meminta pengguna untuk memasukkan alamat dompet dan menambahkannya ke wallets.txt
echo "Masukkan alamat dompet Anda (dimulai dengan 0x):"
read wallet_address

# Memeriksa apakah alamat dompet valid (pemeriksaan sederhana apakah dimulai dengan 0x)
if [[ $wallet_address =~ ^0x ]]; then
    echo $wallet_address >> wallets.txt
    echo "Alamat dompet telah ditambahkan ke wallets.txt"
else
    echo "Kesalahan: Alamat dompet harus dimulai dengan 0x. Skrip dihentikan."
    exit 1
fi

# Menjalankan skrip untuk memulai
npm run start
