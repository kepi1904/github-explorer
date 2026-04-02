import 'package:flutter/material.dart';
import 'package:github_explorer/config/app_theme.dart';

/// Widget reusable untuk menampilkan statistik (icon + angka + label)
/// Digunakan di halaman detail repository dan profil user
class StatWidget extends StatelessWidget {
  /// Icon yang ditampilkan
  final IconData icon;

  /// Warna icon
  final Color iconColor;

  /// Nilai angka yang ditampilkan
  final String value;

  /// Label deskripsi statistik
  final String label;

  const StatWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Container icon dengan background warna muda
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withAlpha(25),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(height: 8),

        /// Nilai angka (bold)
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),

        /// Label deskripsi
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  /// Helper untuk memformat angka besar (contoh: 48981 -> 49.0k)
  static String formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}
