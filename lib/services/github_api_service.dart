import 'package:dio/dio.dart';
import 'package:github_explorer/config/app_constants.dart';
import 'package:github_explorer/config/app_strings.dart';
import 'package:github_explorer/models/search_response_model.dart';
import 'package:github_explorer/models/user_model.dart';

/// Service untuk berkomunikasi dengan GitHub REST API
/// Menggunakan Dio sebagai HTTP client
class GithubApiService {
  late final Dio _dio;

  /// Constructor: menginisialisasi Dio dengan base URL dan timeout
  GithubApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(
        milliseconds: AppConstants.connectTimeout,
      ),
      receiveTimeout: const Duration(
        milliseconds: AppConstants.receiveTimeout,
      ),
      headers: {
        'Accept': 'application/vnd.github.v3+json',
      },
    ));
  }

  /// Mencari repository berdasarkan keyword dengan pagination
  /// [query] - kata kunci pencarian
  /// [page] - nomor halaman (default: 1)
  /// Return: SearchResponseModel berisi list repository
  Future<SearchResponseModel> searchRepositories({
    required String query,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get(
        '/search/repositories',
        queryParameters: {
          'q': query,
          'page': page,
          'per_page': AppConstants.perPage,
        },
      );
      return SearchResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Mengambil profil user GitHub berdasarkan username
  /// [username] - username GitHub yang ingin dilihat profilnya
  /// Return: UserModel berisi informasi profil user
  Future<UserModel> getUserProfile(String username) async {
    try {
      final response = await _dio.get('/users/$username');
      return UserModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Menangani error dari Dio dan mengubahnya menjadi pesan yang friendly
  /// [e] - DioException yang ditangkap
  /// Return: String pesan error yang bisa ditampilkan ke user
  String _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppStrings.timeoutError;
      case DioExceptionType.connectionError:
        return AppStrings.errorNetwork;
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 403) {
          return AppStrings.errorRateLimit;
        } else if (statusCode == 404) {
          return AppStrings.dataNotFound;
        } else if (statusCode == 422) {
          return AppStrings.invalidSearch;
        }
        return '${AppStrings.serverError} ($statusCode).';
      default:
        return AppStrings.errorUnknown;
    }
  }
}
