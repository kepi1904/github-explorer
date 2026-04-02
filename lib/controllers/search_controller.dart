import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_explorer/config/app_strings.dart';
import 'package:github_explorer/models/repository_model.dart';
import 'package:github_explorer/services/github_api_service.dart';

/// Controller untuk halaman pencarian repository
/// Mengelola state pencarian, pagination (infinite scroll), loading & error
class RepoSearchController extends GetxController {
  final GithubApiService _apiService = GithubApiService();

  /// List repository hasil pencarian (observable)
  final repositories = <RepositoryModel>[].obs;

  /// Status loading saat fetch data
  final isLoading = false.obs;

  /// Status loading saat load halaman berikutnya
  final isLoadingMore = false.obs;

  /// Pesan error jika terjadi kesalahan
  final errorMessage = ''.obs;

  /// Query pencarian saat ini
  final searchQuery = ''.obs;

  /// Apakah pencarian sudah pernah dilakukan
  final hasSearched = false.obs;

  /// Halaman saat ini untuk pagination
  int _currentPage = 1;

  /// Total hasil pencarian dari API
  int _totalCount = 0;

  /// Mengecek apakah masih ada data untuk di-load
  bool get hasMore => repositories.length < _totalCount;

  /// Melakukan pencarian repository baru
  /// Reset halaman dan list, lalu fetch data dari halaman 1
  /// [query] - kata kunci pencarian
  Future<void> searchRepos(String query) async {
    if (query.trim().isEmpty) return;

    searchQuery.value = query.trim();
    _currentPage = 1;
    repositories.clear();
    errorMessage.value = '';
    isLoading.value = true;

    try {
      final response = await _apiService.searchRepositories(
        query: searchQuery.value,
        page: _currentPage,
      );
      _totalCount = response.totalCount;
      repositories.addAll(response.items);
      hasSearched.value = true;
    } catch (e) {
      errorMessage.value = e.toString();
      _showError(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  /// Memuat halaman berikutnya untuk infinite scroll
  /// Hanya dijalankan jika tidak sedang loading dan masih ada data
  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMore) return;

    isLoadingMore.value = true;
    _currentPage++;

    try {
      final response = await _apiService.searchRepositories(
        query: searchQuery.value,
        page: _currentPage,
      );
      repositories.addAll(response.items);
    } catch (e) {
      _currentPage--; // Rollback halaman jika gagal
      errorMessage.value = e.toString();
      _showError(errorMessage.value);
    } finally {
      isLoadingMore.value = false;
    }
  }

  void _showError(String msg) {
    if (repositories.isNotEmpty) {
      Get.snackbar(
        AppStrings.errorTitle,
        msg,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    }
  }
}
