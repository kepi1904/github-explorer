import 'package:get/get.dart';
import 'package:github_explorer/models/user_model.dart';
import 'package:github_explorer/services/github_api_service.dart';

/// Controller untuk halaman profil user GitHub
/// Mengambil data profil dari API berdasarkan username
class ProfileController extends GetxController {
  final GithubApiService _apiService = GithubApiService();

  /// Data profil user (observable, nullable)
  final user = Rxn<UserModel>();

  /// Status loading saat fetch data profil
  final isLoading = false.obs;

  /// Pesan error jika terjadi kesalahan
  final errorMessage = ''.obs;

  /// Lifecycle: dipanggil saat controller pertama kali dibuat
  /// Mengambil username dari Get.arguments lalu fetch profil
  @override
  void onInit() {
    super.onInit();
    final username = Get.arguments as String?;
    if (username != null) {
      fetchUserProfile(username);
    }
  }

  /// Mengambil data profil user dari GitHub API
  /// [username] - username GitHub yang ingin dilihat
  Future<void> fetchUserProfile(String username) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _apiService.getUserProfile(username);
      user.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
