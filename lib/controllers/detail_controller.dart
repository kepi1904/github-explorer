import 'package:get/get.dart';
import 'package:github_explorer/models/repository_model.dart';

/// Controller untuk halaman detail repository
/// Menerima data repository dari halaman sebelumnya via arguments
class DetailController extends GetxController {
  /// Data repository yang sedang ditampilkan (observable)
  final repository = Rxn<RepositoryModel>();

  /// Lifecycle: dipanggil saat controller pertama kali dibuat
  /// Mengambil data repository dari Get.arguments
  @override
  void onInit() {
    super.onInit();
    _loadRepository();
  }

  /// Memuat data repository dari arguments navigasi
  /// Data dikirim dari halaman pencarian saat item diklik
  void _loadRepository() {
    final repo = Get.arguments as RepositoryModel?;
    if (repo != null) {
      repository.value = repo;
    }
  }
}
