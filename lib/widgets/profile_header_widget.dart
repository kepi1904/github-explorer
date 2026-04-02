import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_explorer/config/app_theme.dart';

/// Widget reusable untuk menampilkan header profil user
/// Menampilkan avatar besar, nama, username, bio, lokasi, perusahaan
class ProfileHeaderWidget extends StatelessWidget {
  /// URL avatar user
  final String avatarUrl;

  /// Nama lengkap user (fallback ke login jika null)
  final String displayName;

  /// Username login
  final String login;

  /// Bio user (opsional)
  final String? bio;

  /// Lokasi user (opsional)
  final String? location;

  /// Perusahaan user (opsional)
  final String? company;

  const ProfileHeaderWidget({
    super.key,
    required this.avatarUrl,
    required this.displayName,
    required this.login,
    this.bio,
    this.location,
    this.company,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Avatar user (bulat, besar) dengan border
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.primaryColor, width: 3),
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: avatarUrl,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                width: 110,
                height: 110,
                color: AppTheme.borderColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        /// Nama lengkap user
        Text(
          displayName,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),

        /// Username (@login)
        Text(
          '@$login',
          style: const TextStyle(
            color: AppTheme.primaryColor,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 12),

        /// Bio user (jika ada)
        if (bio != null && bio!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              bio!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),

        /// Info lokasi dan perusahaan
        if (location != null || company != null)
          _buildInfoChips(),
      ],
    );
  }

  /// Menampilkan chip informasi lokasi dan perusahaan
  Widget _buildInfoChips() {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        if (location != null && location!.isNotEmpty)
          _buildChip(Icons.location_on_outlined, location!),
        if (company != null && company!.isNotEmpty)
          _buildChip(Icons.business_outlined, company!),
      ],
    );
  }

  /// Membuat chip individual (icon + text)
  Widget _buildChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withAlpha(15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppTheme.primaryColor, size: 15),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
