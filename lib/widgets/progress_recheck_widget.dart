import 'package:flutter/material.dart';
import 'package:github_explorer/config/app_assets.dart';
import 'package:github_explorer/config/app_strings.dart';
import 'package:github_explorer/config/app_theme.dart';

class ProgressRecheckWidget extends StatelessWidget {
  const ProgressRecheckWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 10, bottom: 5),
          child: Text(
            AppStrings.recheckProgress,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: const Color(0x1A000000), blurRadius: 4),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 16),
              const Text(
                AppStrings.lastUpdated,
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
              ),
              const SizedBox(height: 12),
              _btn(),
              const SizedBox(height: 16),
              _footer(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _header() => Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.bodyBetter,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const Text(
              AppStrings.bodyBalanceSub,
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
            ),
          ],
        ),
      ),
      Image.asset(
        AppAssets.rightArrow,
        width: 24,
        height: 24,
        errorBuilder: (c, e, s) => const Icon(Icons.chevron_right),
      ),
    ],
  );

  Widget _btn() => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.updateHere,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: const Text(
        AppStrings.updateHere,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );

  Widget _footer() => Row(
    children: [
      Image.asset(AppAssets.seru, width: 20, height: 20),
      const SizedBox(width: 8),
      const Expanded(
        child: Text(
          AppStrings.updateGoals,
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 10),
        ),
      ),
    ],
  );
}
