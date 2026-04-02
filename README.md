# 📱 GitHub Explorer

Aplikasi mobile Flutter premium untuk eksplorasi repository dan profil GitHub menggunakan GetX & Dio.

---

## 🏗️ Arsitektur Aplikasi (GetX-Layered)

Aplikasi mengikuti pola arsitektur **MVC** yang modular, dengan pembatasan ketat **maksimal 150 baris per file** untuk menjaga kebersihan dan skalabilitas kode.

### 📁 Struktur Direktori

- **lib/config/**: Pusat konfigurasi global.
  - `app_assets.dart`: [NEW] Sentralisasi semua path/ikon gambar.
  - `app_theme.dart`: Sistem desain (warna premium, tipografi, tema).
  - `app_routes.dart` & `app_bindings.dart`: Routing & Dependency Injection.
- **lib/controllers/**: Logika bisnis reaktif (GetxController).
  - Mengelola state pencarian, detail, profil, dan interaksi (e.g., Activity Select).
- **lib/widgets/**: Komponen UI modular (Atomic Design).
  - `today_activity_widget.dart`: Layout GridView 2x2 responsif dengan dropdown aktivitas.
  - `log_weight_widget.dart`: Visualisasi data berbasis Stacked Bar Chart.
  - `user_profile_header.dart`: Header statistik user dengan sticky behavior.
- **lib/views/**: Halaman layar utama yang bersih dan fokus pada susunan widget.
- **lib/services/**: Integrasi API GitHub via Dio (Singleton & Interceptors).
- **lib/models/**: Pemodelan data JSON reaktif.

---

## 📐 Prinsip & Aturan Utama

1. **Single Responsibility**: Setiap widget/file hanya menangani satu tugas spesifik.
2. **File Integrity**: Wajib **< 150 baris** untuk setiap file `.dart`.
3. **Reactive Binding**: UI secara otomatis terupdate menggunakan `Obx(() => ...)` tanpa `setState`.
4. **Centralized Assets**: Dilarang melakukan hardcode string path gambar di dalam widget; gunakan `AppAssets`.
5. **Sticky Nav & SafeArea**: Navigasi menggunakan `SliverPersistentHeader` untuk pengalaman user yang premium saat scroll.

---

## 🔧 Teknologi Utama

- **State Management**: GetX (Reactive & Routing).
- **Network**: Dio (HTTP client dengan auto-retry & error handling).
- **Image**: CachedNetworkImage (Performa pemuatan gambar tinggi).
- **UI FX**: Shimmer (Skeleton loading premium).

---

## 🚀 Cara Menjalankan

1. `flutter pub get`
2. `flutter run` (Support iOS & Android)

> **Info:** Rate limit GitHub API (60 req/jam) ditangani oleh `AppErrorWidget` untuk memberikan feedback informatif jika limit tercapai.
