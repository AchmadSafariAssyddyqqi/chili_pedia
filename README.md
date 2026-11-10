# 🌶️ ChiliCare - Buku Saku Pengendalian Hama & Penyakit Cabai

Aplikasi panduan digital **100% Offline** untuk membantu petani cabai, penyuluh pertanian, dan mahasiswa pertanian dalam mengidentifikasi serta mengendalikan hama dan penyakit pada tanaman cabai secara cepat, tepat, dan ramah lingkungan.

> Dibuat untuk memenuhi tugas mata kuliah **Mobile Programming Lanjut**.

---

## 🖼️ Galeri Asset Gambar & Visual Lapangan

Aplikasi kini telah dilengkapi asset gambar beresolusi tinggi di direktori `assets/images/`:
1. `kebun_cabai.png`: Banner lanskap kebun cabai terpadu pada dashboard utama.
2. `gemini_virus.png`: Foto visual daun cabai menguning terang (bule) dan melengkung keriting akibat infeksi virus Gemini.
3. `antraknosa.png`: Foto visual buah cabai merah dengan lesi cekung hitam konsentris melingkar (patek).
4. `bercak_daun.png`: Foto visual daun cabai dengan bercak bulat mata katak (*frog-eye*) jamur Cercospora.
5. `kutu_daun.png`: Foto visual koloni serangga kutu daun (*Aphids*) pada pucuk tanaman dan embun madu.
6. `lalat_buah.png`: Foto visual buah cabai busuk basah akibat sengatan ovipositor lalat buah (*Bactrocera sp.*).

> **Fitur Zoom Lapangan (Pinch to Zoom):** Pada halaman detail ([`detail_screen.dart`](file:///c:/Project%20Aplikasi/chili_pedia/lib/screens/detail_screen.dart)), pengguna dapat mengetuk banner foto untuk membuka mode *InteractiveViewer* (perbesar hingga 4x) guna mencocokkan gejala klinis daun dan buah secara mendalam di kebun.

---

## 📱 Arsitektur Layar (Screen Flow)

Aplikasi mengimplementasikan alur layar lengkap sesuai *Product Requirements Document (PRD)* beserta fitur penunjang kebun:

1. **Layar 1: Splash Screen (`SplashScreen`)**
   - Menampilkan logo aplikasi dengan animasi *fade & scale*, judul *ChiliCare*, tagline, serta kredit pengembang.
   - Menggunakan timer transisi otomatis (2.6 detik) langsung berpindah ke Dashboard Utama.
2. **Layar 2: Home / Dashboard (`HomeScreen`)**
   - Header ramah dengan ucapan selamat datang untuk petani cabai.
   - Banner gambar visual kebun cabai asli (`kebun_cabai.png`).
   - Dua tombol menu kategori utama:
     - 🌿 **Daftar Penyakit** (Jamur, Bakteri & Virus)
     - 🐛 **Daftar Hama** (Serangga Perusak & Pengisap)
   - Menu Cepat Petani: **Diagnosa Cepat Gejala**, **Kalkulator Dosis Tangki Semprot**, dan **Uji Pemahaman (Kuis)**.
   - Tombol Pantauan Kebun (Bookmark dengan live badge) & Tentang Aplikasi di AppBar.
3. **Layar 3: List Penyakit / Hama (`ListScreen`)**
   - Daftar kartu (*Card*) yang dapat digulir (*scrollable*) bebas overflow.
   - Thumbnail foto asli beresolusi tajam untuk setiap penyakit dan hama.
   - Fitur **Pencarian Cepat (Search Bar)** offline berdasarkan nama hama/penyakit, bagian yang diserang, maupun gejala.
   - Menampilkan nama penyakit/hama, nama latin/alias (*italic*), *badge* bagian yang diserang (Daun / Buah), dan cuplikan gejala.
4. **Layar 4: Detail Informasi (`DetailScreen`)**
   - Header gambar sliver besar dengan gradient overlay dan tombol perbesar foto (*Pinch to Zoom*).
   - Kartu bagian yang diserang, ciri-ciri & gejala klinis, penyebab organisme, serta solusi pengendalian terpadu.
   - Tombol fitur **Bookmark Pantauan Kebun**, **Salin Ringkasan Solusi**, dan **Tandai Telah Dibaca**.
5. **Layar Tambahan: Diagnosa Cepat Gejala (`DiagnosisScreen`)**
   - Filter interaktif berdasarkan organ yang diserang: *Semua*, *Daun*, *Buah Cabai*, *Pucuk & Tunas*.
6. **Layar Tambahan: Kalkulator Dosis Semprot (`DosageCalculatorScreen`)**
   - Perhitungan takaran pestisida / fungisida (bubuk/cair) per tangki semprot (14-16 liter) dan estimasi kebutuhan tangki per luasan lahan.
7. **Layar Tambahan: Uji Pemahaman Hama Cabai (`QuizScreen`)**
   - Kuis interaktif 5 soal studi kasus gejala lapangan dengan kalkulasi skor akhir dan evaluasi belajar.
8. **Layar Informasi: Tentang Aplikasi (`AboutScreen`)**
   - Informasi akademik mata kuliah *Mobile Programming Lanjut*, profil pengembang, dan tujuan aplikasi.

---

## 🏛️ Pemetaan Komponen Penilaian (Android Native ➡️ Flutter)

| Komponen Android Native (PRD) | Implementasi di Flutter | File Sumber |
| :--- | :--- | :--- |
| **Activity / Screen Flow** | `SplashScreen`, `HomeScreen`, `ListScreen`, `DetailScreen`, `DiagnosisScreen`, `DosageCalculatorScreen`, `QuizScreen`, `BookmarkScreen` | `lib/screens/` |
| **Intent (Pindah Layar & Data)** | `Navigator.push`, `Navigator.pushReplacement`, `MaterialPageRoute` | `splash_screen.dart`, `home_screen.dart`, `list_screen.dart` |
| **LinearLayout / ConstraintLayout** | `Column`, `Row`, `Stack`, `Container`, `Padding`, `Flexible`, `Expanded` | Di seluruh berkas UI |
| **Button / Interaksi** | `InkWell`, `ElevatedButton`, `IconButton`, `InteractiveViewer` | `home_screen.dart`, `detail_screen.dart` |
| **RecyclerView & Adapter** | `ListView.builder` dengan data dinamis dari `ChiliData` | `list_screen.dart`, `diagnosis_screen.dart` |
| **CardView** | `Container` dengan `BoxDecoration`, `BorderRadius`, dan `BoxShadow` halus | `list_screen.dart`, `detail_screen.dart` |
| **ScrollView / Nested Scroll** | `SingleChildScrollView`, `CustomScrollView`, `SliverAppBar` | `home_screen.dart`, `detail_screen.dart` |
| **Asset Images** | `Image.asset` dengan folder `assets/images/` terdaftar di `pubspec.yaml` | `assets/images/`, `pubspec.yaml` |
| **Data Class / String Array** | `PestDiseaseModel` & `ChiliData` | `lib/models/pest_disease_model.dart`, `lib/data/chili_data.dart` |

---

## 📦 Struktur Folder Proyek

```text
chili_pedia/
├── assets/
│   └── images/
│       ├── kebun_cabai.png        # Banner lanskap kebun cabai
│       ├── gemini_virus.png       # Foto visual Virus Gemini (Bule)
│       ├── antraknosa.png         # Foto visual Antraknosa (Patek)
│       ├── bercak_daun.png        # Foto visual Bercak Daun Cercospora
│       ├── kutu_daun.png          # Foto visual Kutu Daun Aphids
│       └── lalat_buah.png         # Foto visual Lalat Buah & larva
├── lib/
│   ├── main.dart                  # Inisialisasi aplikasi & tema Material 3
│   ├── models/
│   │   ├── pest_disease_model.dart # Model data hama & penyakit
│   │   └── spray_log_model.dart    # Model jurnal penyemprotan
│   ├── data/
│   │   └── chili_data.dart        # Dataset lokal 100% offline
│   ├── services/
│   │   ├── bookmark_service.dart  # State management pantauan kebun
│   │   └── spray_log_service.dart # State management jurnal semprot
│   └── screens/
│       ├── splash_screen.dart     # Layar 1: Splash screen animasi 2.6 detik
│       ├── home_screen.dart       # Layar 2: Dashboard & banner kebun cabai
│       ├── list_screen.dart       # Layar 3: Daftar kartu + thumbnail foto riil
│       ├── detail_screen.dart     # Layar 4: Detail informasi + Pinch-to-Zoom
│       ├── diagnosis_screen.dart  # Diagnosa cepat organ tanaman
│       ├── calculator_screen.dart # Kalkulator dosis tangki semprot
│       ├── quiz_screen.dart       # Kuis interaktif pemahaman materi
│       ├── bookmark_screen.dart   # Halaman item pantauan kebun saya
│       ├── spray_log_screen.dart  # Jurnal catatan penyemprotan
│       └── about_screen.dart      # Info akademik tugas kuliah & developer
└── pubspec.yaml                   # Registrasi dependensi & asset gambar
```

---

## 🚀 Cara Menjalankan Aplikasi

1. Ambil dependensi terbaru:
   ```bash
   flutter pub get
   ```
2. Jalankan aplikasi di HP atau emulator:
   ```bash
   flutter run
   ```
3. Tekan **`R`** (Hot Restart) jika aplikasi sedang berjalan agar Flutter memuat folder asset gambar baru.
4. Buat file APK rilis:
   ```bash
   flutter build apk --release
   ```
   *File APK rilis siap kumpul berada di `build/app/outputs/flutter-apk/app-release.apk`.*
