#!/bin/bash

# Periksa apakah skrip dijalankan sebagai root
if [ "$EUID" -ne 0 ]; then
    echo "Harap jalankan skrip ini sebagai root: sudo $0"
    exit 1
fi

# Menjalankan skrip logo
curl -s https://raw.githubusercontent.com/choir94/Airdropguide/refs/heads/main/logo.sh | bash
sleep 3

# Perbarui sistem dan instal dependensi
echo "[+] Memperbarui sistem dan menginstal dependensi..."
apt update && apt install -y git nodejs npm screen

# Periksa apakah screen terinstal
if ! command -v screen &> /dev/null; then
    echo "[-] Screen tidak terinstal. Instalasi gagal."
    exit 1
fi

# Clone repository jika belum ada
if [ ! -d "Kaleido" ]; then
    echo "[+] Meng-clone repository Kaleido..."
    git clone https://github.com/choir94/Kaleido.git
fi

# Masuk ke direktori proyek
cd Kaleido || { echo "[-] Gagal masuk ke direktori Kaleido"; exit 1; }

# Perbarui repository jika sudah ada
echo "[+] Menarik pembaruan terbaru dari repository..."
git pull

# Periksa dan instal dependensi
echo "[+] Menginstal dependensi Node.js..."
npm install || { echo "[-] Instalasi dependensi gagal"; exit 1; }

# Buat file wallets.txt jika belum ada
if [ ! -f "wallets.txt" ]; then
    echo "[+] Membuat file wallets.txt..."
    touch wallets.txt
fi

# Berhenti dan minta pengguna memasukkan alamat wallet sebelum lanjut
echo "Masukkan alamat wallet satu per baris di wallets.txt, lalu simpan dan keluar."
nano wallets.txt

# Pastikan file wallets.txt tidak kosong sebelum lanjut
while [ ! -s "wallets.txt" ]; do
    echo "[-] File wallets.txt kosong! Masukkan alamat wallet sebelum melanjutkan."
    nano wallets.txt
done

# Jalankan bot dalam screen
echo "[+] Menjalankan bot di dalam screen..."
screen -dmS kaleido-bot npm run start || { echo "[-] Gagal menjalankan bot!"; exit 1; }

echo "[✔] Bot sedang berjalan di dalam screen."
echo "Gunakan 'screen -r kaleido-bot' untuk melihat log."
