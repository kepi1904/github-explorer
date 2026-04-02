import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_explorer/config/app_strings.dart';
import 'package:github_explorer/config/app_theme.dart';
import 'package:github_explorer/controllers/detail_controller.dart';
import 'package:github_explorer/widgets/owner_section_widget.dart';
import 'package:github_explorer/widgets/stat_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailController>();

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.detailRepo)),
      body: Obx(() {
        final repo = controller.repository.value;
        if (repo == null) {
          return const Center(child: Text(AppStrings.dataNotAvailable));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Nama repository
              Text(
                repo.name,
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                repo.fullName,
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),

              /// Owner section (klik ke profil)
              OwnerSectionWidget(
                avatarUrl: repo.ownerAvatarUrl,
                login: repo.ownerLogin,
              ),
              const SizedBox(height: 20),

              /// Statistik Stars & Forks
              _statsCard(repo.stargazersCount, repo.forksCount),
              const SizedBox(height: 20),

              /// Deskripsi
              if (repo.description != null && repo.description!.isNotEmpty) ...[
                _descCard(repo.description!),
                const SizedBox(height: 20),
              ],

              /// Tombol buka di browser
              _openButton(repo.htmlUrl),
            ],
          ),
        );
      }),
    );
  }

  Widget _statsCard(int stars, int forks) => Container(
    padding: const EdgeInsets.symmetric(vertical: 20), decoration: _cardDecoration(),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        StatWidget(icon: Icons.star_rounded, iconColor: AppTheme.starColor, value: StatWidget.formatCount(stars), label: AppStrings.stars),
        StatWidget(icon: Icons.fork_right_rounded, iconColor: AppTheme.forkColor, value: StatWidget.formatCount(forks), label: AppStrings.forks),
    ]));

  Widget _descCard(String desc) => Container(
    width: double.infinity, padding: const EdgeInsets.all(16), decoration: _cardDecoration(),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(AppStrings.description, style: TextStyle(color: AppTheme.textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Text(desc, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14, height: 1.5)),
    ]));

  Widget _openButton(String url) => SizedBox(width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () async {
        try { await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication); }
        catch (e) { Get.snackbar(AppStrings.errorTitle, '${AppStrings.cannotOpenBrowser}: $e'); }
      },
      icon: const Icon(Icons.open_in_browser_rounded), label: const Text(AppStrings.openInBrowser),
      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))));

  BoxDecoration _cardDecoration() => BoxDecoration(color: AppTheme.surfaceColor, borderRadius: BorderRadius.circular(16),
    boxShadow: [BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 10, offset: const Offset(0, 2))]);
}

