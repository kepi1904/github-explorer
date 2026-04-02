import 'package:flutter/material.dart';
import 'package:github_explorer/config/app_theme.dart';
import 'package:shimmer/shimmer.dart';

/// Widget loading skeleton menggunakan shimmer effect
/// Menampilkan placeholder animasi saat data sedang di-fetch
class LoadingWidget extends StatelessWidget {
  /// Jumlah item skeleton yang ditampilkan
  final int itemCount;

  const LoadingWidget({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      itemBuilder: (context, index) => _buildShimmerItem(),
    );
  }

  /// Membuat satu item skeleton dengan shimmer effect
  Widget _buildShimmerItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Shimmer.fromColors(
        baseColor: AppTheme.borderColor.withAlpha(80),
        highlightColor: AppTheme.surfaceColor,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Placeholder header (avatar + nama)
              Row(
                children: [
                  _buildPlaceholder(width: 44, height: 44, radius: 12),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPlaceholder(width: 160, height: 14),
                      const SizedBox(height: 6),
                      _buildPlaceholder(width: 100, height: 12),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              /// Placeholder deskripsi
              _buildPlaceholder(width: double.infinity, height: 12),
              const SizedBox(height: 6),
              _buildPlaceholder(width: 220, height: 12),
              const SizedBox(height: 12),

              /// Placeholder stats
              Row(
                children: [
                  _buildPlaceholder(width: 60, height: 12),
                  const SizedBox(width: 16),
                  _buildPlaceholder(width: 60, height: 12),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Membuat placeholder dengan ukuran dan radius custom
  Widget _buildPlaceholder({
    required double width,
    required double height,
    double radius = 6,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.borderColor.withAlpha(120),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
