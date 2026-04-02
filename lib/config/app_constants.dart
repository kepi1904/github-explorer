/// Konstanta aplikasi GitHub Explorer
/// Menyimpan konfigurasi statis yang digunakan di seluruh aplikasi
class AppConstants {
  /// Base URL untuk GitHub REST API
  static const String baseUrl = 'https://api.github.com';

  /// Jumlah item per halaman untuk pagination
  static const int perPage = 20;

  /// Timeout durasi untuk request API (dalam milidetik)
  static const int connectTimeout = 15000;

  /// Timeout durasi untuk menerima response (dalam milidetik)
  static const int receiveTimeout = 15000;
}
