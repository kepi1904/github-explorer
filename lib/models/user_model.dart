/// Model untuk merepresentasikan data User/Profile dari GitHub API
/// Digunakan di halaman profil user
class UserModel {
  /// Username GitHub
  final String login;

  /// URL foto profil user
  final String avatarUrl;

  /// Nama lengkap user (bisa null)
  final String? name;

  /// Bio/deskripsi user (bisa null)
  final String? bio;

  /// Nama perusahaan (bisa null)
  final String? company;

  /// Lokasi user (bisa null)
  final String? location;

  /// URL blog/website user (bisa null)
  final String? blog;

  /// Jumlah repository public
  final int publicRepos;

  /// Jumlah followers
  final int followers;

  /// Jumlah akun yang diikuti
  final int following;

  /// Constructor untuk UserModel
  UserModel({
    required this.login,
    required this.avatarUrl,
    this.name,
    this.bio,
    this.company,
    this.location,
    this.blog,
    required this.publicRepos,
    required this.followers,
    required this.following,
  });

  /// Factory constructor untuk parsing dari JSON response API
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json['login'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
      name: json['name'] as String?,
      bio: json['bio'] as String?,
      company: json['company'] as String?,
      location: json['location'] as String?,
      blog: json['blog'] as String?,
      publicRepos: json['public_repos'] as int? ?? 0,
      followers: json['followers'] as int? ?? 0,
      following: json['following'] as int? ?? 0,
    );
  }
}
