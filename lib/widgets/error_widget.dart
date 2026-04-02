import 'package:flutter/material.dart';
import 'package:github_explorer/config/app_strings.dart';
import 'package:github_explorer/config/app_theme.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const AppErrorWidget({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final isNoInt = message.toLowerCase().contains('internet') || 
                   message.toLowerCase().contains('koneksi');
    return Center(child: Padding(padding: const EdgeInsets.all(32),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: (isNoInt ? Colors.blue : AppTheme.errorColor).withAlpha(20), shape: BoxShape.circle),
          child: Icon(isNoInt ? Icons.wifi_off_rounded : Icons.cloud_off_rounded,
            color: isNoInt ? Colors.blue : AppTheme.errorColor, size: 64)),
        const SizedBox(height: 24),
        Text(isNoInt ? AppStrings.noInternet : AppStrings.serverError,
          style: const TextStyle(color: AppTheme.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(message, textAlign: TextAlign.center,
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
        const SizedBox(height: 32),
        _btn(),
      ])));
  }

  Widget _btn() => ElevatedButton.icon(onPressed: onRetry,
    icon: const Icon(Icons.refresh_rounded, size: 20), label: const Text(AppStrings.retry),
    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor,
      foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))));
}
