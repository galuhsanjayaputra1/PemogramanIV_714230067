# Praktikum 3 – Flutter UI Dasar (MaterialApp, Scaffold, dan Widget Interaktif)

Proyek ini merupakan latihan pembuatan aplikasi Flutter dengan tampilan **tema terang (Light Mode)** menggunakan **Material Design 3**.
Aplikasi ini menampilkan contoh penerapan widget dasar seperti `Scaffold`, `AppBar`, `Drawer`, `BottomNavigationBar`, serta penggunaan **StatefulWidget** untuk membuat teks yang dapat diperbesar dan diperkecil secara interaktif.

---

## 🖼️ Tampilan Aplikasi

Aplikasi terdiri dari beberapa komponen utama:

* **AppBar** berjudul *Halaman Awal* dengan warna biru.
* **Drawer** (menu samping) berisi pilihan *Home* dan *About*.
* **Bottom Navigation Bar** memiliki tiga menu: *Home*, *Account*, dan *Setting*.
* **Halaman utama** menampilkan teks *Hello ULB!* dan tombol *Perkecil / Perbesar*.

---

## 📁 Struktur Folder

```
lib/
│
├── main.dart
├── materialApp.dart
├── materialPage.dart
├── stateful.dart
└── stateless.dart
```

---

## 📘 Penjelasan File

### `main.dart`

File utama yang menjalankan aplikasi Flutter menggunakan `runApp()` dan memanggil `AppMaterial()` sebagai root widget.

### `materialApp.dart`

Mengatur konfigurasi `MaterialApp` dengan tema terang:

* Warna utama: biru (`Color(0xFF1976D2)`)
* Menghapus label debug (`debugShowCheckedModeBanner: false`)
* Menampilkan halaman `HomePage()` sebagai halaman awal.

### `materialPage.dart`

Mengatur tampilan utama aplikasi:

* `AppBar` biru dengan teks *Halaman Awal*
* `Drawer` berisi menu *Home* dan *About*
* `BottomNavigationBar` dengan 3 item: *Home*, *Account*, *Setting*
* Konten utama berubah sesuai tab yang dipilih.

### `stateful.dart`

Contoh penggunaan **StatefulWidget** yang menampilkan teks *Hello world!* dengan tombol untuk mengubah ukuran teks secara interaktif.

### `stateless.dart`

Contoh penggunaan **StatelessWidget** yang menampilkan teks *Hello world, stateless!*.

---

## ▶️ Cara Menjalankan Proyek

1. Pastikan **Flutter SDK** sudah terinstal.
2. Buka folder proyek di **Visual Studio Code**.
3. Jalankan perintah berikut di terminal:

   ```bash
   flutter pub get
   flutter run
   ```
4. Pilih emulator atau perangkat yang aktif untuk menjalankan aplikasi.

---

## 🎨 Tema Aplikasi

Aplikasi ini menggunakan **tema terang (Light Mode)** dengan kombinasi warna:

* **Primary Color:** Biru (`#1976D2`)
* **Background:** Putih
* **Accent:** Abu-abu muda

---

## 📚 Kesimpulan

Proyek ini melatih penggunaan widget dasar Flutter seperti `MaterialApp`, `Scaffold`, `AppBar`, `Drawer`, `BottomNavigationBar`, serta konsep **StatefulWidget** dan **StatelessWidget**.
