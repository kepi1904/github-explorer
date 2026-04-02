import 'package:github_explorer/models/repository_model.dart';

/// Model untuk merepresentasikan response dari GitHub Search API
/// Membungkus total count dan list of repositories
class SearchResponseModel {
  /// Total jumlah repository yang ditemukan
  final int totalCount;

  /// Menandakan apakah hasil pencarian tidak lengkap
  final bool incompleteResults;

  /// Daftar repository hasil pencarian
  final List<RepositoryModel> items;

  /// Constructor untuk SearchResponseModel
  SearchResponseModel({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  /// Factory constructor untuk parsing dari JSON response API
  /// Mengkonversi setiap item dalam array 'items' menjadi RepositoryModel
  factory SearchResponseModel.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List<dynamic>? ?? [];
    return SearchResponseModel(
      totalCount: json['total_count'] as int? ?? 0,
      incompleteResults: json['incomplete_results'] as bool? ?? false,
      items: itemsList
          .map((item) =>
              RepositoryModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
