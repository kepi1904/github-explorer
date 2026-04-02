import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_explorer/config/app_strings.dart';
import 'package:github_explorer/config/app_theme.dart';
import 'package:github_explorer/controllers/profile_controller.dart';
import 'package:github_explorer/widgets/error_widget.dart';
import 'package:github_explorer/widgets/profile_header_widget.dart';
import 'package:github_explorer/widgets/stat_widget.dart';

/// Halaman profil user GitHub
/// Menampilkan avatar, nama, bio, jumlah repo, followers, following
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.userProfile)),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
            ),
          );
        }

        if (controller.errorMessage.isNotEmpty) {
          return AppErrorWidget(
            message: controller.errorMessage.value,
            onRetry: () {
              final username = Get.arguments as String?;
              if (username != null) {
                controller.fetchUserProfile(username);
              }
            },
          );
        }

        final user = controller.user.value;
        if (user == null) {
          return const Center(child: Text(AppStrings.dataNotAvailable));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              /// Header profil (avatar, nama, bio, info chips)
              ProfileHeaderWidget(
                avatarUrl: user.avatarUrl,
                displayName: user.name ?? user.login,
                login: user.login,
                bio: user.bio,
                location: user.location,
                company: user.company,
              ),
              const SizedBox(height: 24),

              /// Card statistik: Repos, Followers, Following
              _buildStatsCard(
                user.publicRepos,
                user.followers,
                user.following,
              ),
            ],
          ),
        );
      }),
    );
  }

  /// Card statistik dalam container putih dengan shadow
  Widget _buildStatsCard(int repos, int followers, int following) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StatWidget(
            icon: Icons.book_outlined,
            iconColor: AppTheme.primaryColor,
            value: StatWidget.formatCount(repos),
            label: AppStrings.reposLabel,
          ),
          StatWidget(
            icon: Icons.people_outline_rounded,
            iconColor: AppTheme.successColor,
            value: StatWidget.formatCount(followers),
            label: AppStrings.followers,
          ),
          StatWidget(
            icon: Icons.person_add_alt_outlined,
            iconColor: AppTheme.forkColor,
            value: StatWidget.formatCount(following),
            label: AppStrings.following,
          ),
        ],
      ),
    );
  }
}
