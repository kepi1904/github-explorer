import 'package:get/get.dart';
import 'package:github_explorer/models/user_model.dart';
import 'package:github_explorer/services/github_api_service.dart';

/// Controller untuk navigasi utama dan data home page
/// Mengelola tab aktif dan profil default user (Chevy Nanda)
class NavigationController extends GetxController {
  final GithubApiService _apiService = GithubApiService();

  /// Index tab yang sedang aktif di bottom navbar
  final currentIndex = 0.obs;

  /// Index tab di halaman Home (Journal = 0, Update = 1, Activity = 2)
  final homeTabIndex = 1.obs;

  /// Status apakah sedang melakukan pencarian di AppBar
  final isSearching = false.obs;

  /// Data profil default user untuk ditampilkan di home
  final defaultUser = Rxn<UserModel>();

  /// Aktivitas hari ini yang terpilih (Steps, Run, Cycle)
  final selectedActivity = 'Steps'.obs;

  /// Status loading profil default
  final isLoadingUser = false.obs;

  /// Lifecycle: fetch profil user Chevy Nanda saat controller dibuat
  @override
  void onInit() {
    super.onInit();
    fetchDefaultUser();
  }

  /// Mengambil profil user 'ChevyNanda' dari GitHub API
  Future<void> fetchDefaultUser() async {
    isLoadingUser.value = true;
    try {
      final user = await _apiService.getUserProfile('ChevyNanda');
      defaultUser.value = user;
    } catch (_) {
      // Gagal fetch, biarkan null
    } finally {
      isLoadingUser.value = false;
    }
  }

  /// Mengubah tab aktif di bottom navbar
  void changeTab(int index) {
    currentIndex.value = index;
  }

  /// Mengubah tab di halaman Home
  void changeHomeTab(int index) {
    homeTabIndex.value = index;
  }

  /// Toggle status pencarian di AppBar
  void toggleSearch() {
    isSearching.value = !isSearching.value;
  }
}
