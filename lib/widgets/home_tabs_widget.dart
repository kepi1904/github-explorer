import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_explorer/config/app_strings.dart';
import 'package:github_explorer/config/app_theme.dart';
import 'package:github_explorer/controllers/navigation_controller.dart';
import 'package:github_explorer/widgets/user_profile_header.dart';

class HomeTabsWidget extends StatelessWidget {
  const HomeTabsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.find<NavigationController>();
    final tabs = [AppStrings.tabJournal, AppStrings.tabUpdate, AppStrings.tabActivity];
    return Container(
      width: double.infinity,
      height: 47,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.borderColor.withAlpha(50),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) => Expanded(
            child: Obx(() {
              final isActive = navCtrl.homeTabIndex.value == index;
              return GestureDetector(
                onTap: () => navCtrl.changeHomeTab(index),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppTheme.surfaceColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: Colors.black.withAlpha(5),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: isActive
                          ? AppTheme.primaryColor
                          : AppTheme.textSecondary,
                      fontSize: 13,
                      fontWeight: isActive
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext c, double o, bool oH) => SizedBox.expand(
    child: Container(
      color: AppTheme.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const UserProfileHeader(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const HomeTabsWidget()),
        ])));
  @override
  double get maxExtent => 180.0;
  @override
  double get minExtent => 180.0;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate old) => false;
}

class HomeTabsDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext c, double o, bool oH) => Container(
    color: AppTheme.backgroundColor,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    alignment: Alignment.centerLeft,
    child: const HomeTabsWidget(),
  );
  @override
  double get maxExtent => 67.0;
  @override
  double get minExtent => 67.0;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate old) => false;
}
