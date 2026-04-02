import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_explorer/config/app_routes.dart';
import 'package:github_explorer/config/app_strings.dart';
import 'package:github_explorer/config/app_theme.dart';
import 'package:github_explorer/controllers/navigation_controller.dart';
import 'package:github_explorer/widgets/home_tabs_widget.dart';
import 'package:github_explorer/widgets/log_weight_widget.dart';
import 'package:github_explorer/widgets/today_activity_widget.dart';
import 'package:github_explorer/widgets/progress_recheck_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.find<NavigationController>();
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => navCtrl.fetchDefaultUser(),
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: HomeHeaderDelegate(),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 5)),
              SliverToBoxAdapter(child: _searchBar()),
              const SliverToBoxAdapter(
                child: Column(
                  children: [
                    TodayActivityWidget(),
                    LogWeightWidget(),
                    ProgressRecheckWidget(),
                    SizedBox(height: 70),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() => GestureDetector(
    onTap: () => Get.toNamed(AppRoutes.search),
    child: Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.borderColor.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor.withAlpha(80)),
      ),
      child: const Row(
        children: [
          Icon(Icons.search_rounded, color: AppTheme.textSecondary, size: 20),
          SizedBox(width: 12),
          Text(
            AppStrings.searchHint,
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
          ),
        ],
      ),
    ),
  );
}
