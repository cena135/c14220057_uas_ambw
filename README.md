# c14220057_uas_ambw

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Daily Planner

Aplikasi manajemen aktivitas harian berbasis Flutter.

## Fitur

- **Login & Logout**: Autentikasi user menggunakan Supabase.
- **Get Started**: Halaman pengenalan aplikasi saat pertama kali dibuka.
- **Tambah, Lihat, Edit, Hapus Aktivitas**: Mengelola daftar aktivitas harian.
- **Progress Hari Ini**: Menampilkan progress aktivitas yang hanya terjadwal pada hari ini (misal: 1/2 task selesai).
- **Kategori Aktivitas**: Setiap aktivitas memiliki kategori dan warna/icon berbeda.
- **Penyimpanan Status Login**: Menggunakan SharedPreferences untuk menyimpan status login dan onboarding.

## Langkah Install & Build

1. **Clone repo**
   ```
   git clone https://github.com/cena135/c14220057_uas_ambw.git
   cd c14220057_uas_ambw
   ```

2. **Install dependencies**
   ```
   flutter pub get
   ```

3. **Jalankan aplikasi**
    ```
    flutter run
    ```

## Cara lain, menjalankan aplikasi dengan Run and Debug

1. Klik "Run and Debug" di sidebar kiri / `Ctrl+Shift+D`

2. Pilih device

3. Klik tombol "Run and Debug"

## Teknologi yang Digunakan

- **Flutter**: Framework aplikasi.
- **Supabase**: Backend untuk autentikasi dan database aktivitas.
- **SharedPreferences**: Menyimpan status login dan onboarding secara lokal.
- **intl**: Format tanggal dan waktu.

## Dummy User untuk Uji Login

- **Email:** alexanderjoedo@gmail.com
- **Password:** 123123