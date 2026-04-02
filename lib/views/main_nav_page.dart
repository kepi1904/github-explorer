import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_explorer/config/app_strings.dart';
import 'package:github_explorer/config/app_theme.dart';
import 'package:github_explorer/controllers/navigation_controller.dart';
import 'package:github_explorer/views/home_page.dart';
import 'package:github_explorer/config/app_routes.dart';
import 'package:github_explorer/widgets/bottom_nav_bar.dart';

/// Halaman wrapper utama yang mengelola bottom navigation bar
/// Mengatur tampilan 4 tab: Home, Social, Event, Reward
class MainNavPage extends StatelessWidget {
  const MainNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.find<NavigationController>();

    /// Daftar halaman untuk setiap tab
    final pages = [
      const HomePage(),
      _placeholderPage('Social', Icons.people_outline_rounded),
      _placeholderPage('Event', Icons.event_outlined),
      _placeholderPage('Reward', Icons.card_giftcard_rounded),
    ];

    return Scaffold(
      body: Obx(() => pages[navCtrl.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => AppBottomNavBar(
          currentIndex: navCtrl.currentIndex.value,
          onTap: navCtrl.changeTab,
          onFabPressed: () => Get.toNamed(AppRoutes.search),
        ),
      ),
    );
  }

  /// Halaman placeholder untuk tab Social, Event, Reward
  Widget _placeholderPage(String title, IconData icon) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: AppTheme.primaryColor.withAlpha(150),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              AppStrings.comingSoon,
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
