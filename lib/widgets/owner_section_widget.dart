import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_explorer/config/app_routes.dart';
import 'package:github_explorer/config/app_theme.dart';

/// Widget reusable untuk menampilkan section owner repository
/// Menampilkan avatar dan username, bisa diklik ke profil
class OwnerSectionWidget extends StatelessWidget {
  /// URL avatar owner
  final String avatarUrl;

  /// Username owner
  final String login;

  const OwnerSectionWidget({
    super.key,
    required this.avatarUrl,
    required this.login,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /// Navigasi ke halaman profil user saat diklik
      onTap: () => Get.toNamed(AppRoutes.profile, arguments: login),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(8),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            /// Avatar owner berbentuk rounded square
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: avatarUrl,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),

            /// Label dan username
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Owner',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    login,
                    style: const TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            /// Icon panah navigasi
            Icon(
              Icons.chevron_right_rounded,
              color: AppTheme.textSecondary.withAlpha(120),
            ),
          ],
        ),
      ),
    );
  }
}
