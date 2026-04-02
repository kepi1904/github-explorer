/// Model untuk merepresentasikan data Repository dari GitHub API
/// Menyimpan informasi penting tentang sebuah repository
class RepositoryModel {
  /// ID unik repository
  final int id;

  /// Nama repository
  final String name;

  /// Nama lengkap repository (owner/name)
  final String fullName;

  /// Deskripsi repository (bisa null)
  final String? description;

  /// URL halaman repository di GitHub
  final String htmlUrl;

  /// Jumlah stars yang diterima repository
  final int stargazersCount;

  /// Jumlah forks dari repository
  final int forksCount;

  /// Bahasa pemrograman utama (bisa null)
  final String? language;

  /// Username pemilik repository
  final String ownerLogin;

  /// URL avatar pemilik repository
  final String ownerAvatarUrl;

  /// Constructor untuk RepositoryModel
  RepositoryModel({
    required this.id,
    required this.name,
    required this.fullName,
    this.description,
    required this.htmlUrl,
    required this.stargazersCount,
    required this.forksCount,
    this.language,
    required this.ownerLogin,
    required this.ownerAvatarUrl,
  });

  /// Factory constructor untuk parsing dari JSON response API
  /// Mengambil data owner dari nested object 'owner'
  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    final owner = json['owner'] as Map<String, dynamic>;
    return RepositoryModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      description: json['description'] as String?,
      htmlUrl: json['html_url'] as String? ?? '',
      stargazersCount: json['stargazers_count'] as int? ?? 0,
      forksCount: json['forks_count'] as int? ?? 0,
      language: json['language'] as String?,
      ownerLogin: owner['login'] as String? ?? '',
      ownerAvatarUrl: owner['avatar_url'] as String? ?? '',
    );
  }
}
