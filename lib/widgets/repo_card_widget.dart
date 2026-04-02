import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_explorer/config/app_routes.dart';
import 'package:github_explorer/config/app_theme.dart';
import 'package:github_explorer/models/repository_model.dart';
import 'package:github_explorer/widgets/stat_widget.dart';

class RepoCardWidget extends StatelessWidget {
  final RepositoryModel repository;
  const RepoCardWidget({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.detail, arguments: repository),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppTheme.surfaceColor, borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 10, offset: const Offset(0, 2))]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            ClipRRect(borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(imageUrl: repository.ownerAvatarUrl, width: 44, height: 44, fit: BoxFit.cover,
                placeholder: (_, __) => Container(width: 44, height: 44, color: AppTheme.borderColor))),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(repository.name, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 15, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text(repository.ownerLogin, style: TextStyle(color: AppTheme.primaryColor.withAlpha(200), fontSize: 13)),
            ])),
            Icon(Icons.chevron_right_rounded, color: AppTheme.textSecondary.withAlpha(120)),
          ]),
          if (repository.description != null && repository.description!.isNotEmpty)
            Padding(padding: const EdgeInsets.only(top: 12),
              child: Text(repository.description!, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13, height: 1.4), maxLines: 2, overflow: TextOverflow.ellipsis)),
          const SizedBox(height: 12),
          Row(children: [
            _chip(Icons.star_rounded, AppTheme.starColor, StatWidget.formatCount(repository.stargazersCount)),
            const SizedBox(width: 16),
            _chip(Icons.fork_right_rounded, AppTheme.forkColor, StatWidget.formatCount(repository.forksCount)),
            if (repository.language != null) ...[
              const Spacer(),
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppTheme.primaryColor.withAlpha(20), borderRadius: BorderRadius.circular(12)),
                child: Text(repository.language!, style: TextStyle(color: AppTheme.primaryColor.withAlpha(200), fontSize: 11, fontWeight: FontWeight.w500))),
            ],
          ]),
        ]),
      ),
    );
  }


  /// Chip statistik inline (icon + text)
  Widget _chip(IconData icon, Color color, String text) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: color, size: 16),
      const SizedBox(width: 4),
      Text(text, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
    ],
  );
}

