import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_explorer/config/app_strings.dart';
import 'package:github_explorer/config/app_theme.dart';
import 'package:github_explorer/controllers/search_controller.dart';
import 'package:github_explorer/widgets/error_widget.dart';
import 'package:github_explorer/widgets/loading_widget.dart';
import 'package:github_explorer/widgets/repo_card_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RepoSearchController>();
    final textController = TextEditingController();
    final scrollController = ScrollController();

    /// Listener infinite scroll: load more saat mendekati bawah
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        controller.loadMore();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.code_rounded, color: AppTheme.primaryColor, size: 26),
            const SizedBox(width: 8),
            const Text(AppStrings.appName),
          ],
        ),
      ),
      body: Column(
        children: [
          /// Search bar
          Container(
            color: AppTheme.surfaceColor,
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: TextField(
              controller: textController,
              style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14),
              decoration: InputDecoration(
                hintText: AppStrings.searchHint,
                fillColor: AppTheme.backgroundColor,
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppTheme.textSecondary,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.clear_rounded,
                    color: AppTheme.textSecondary,
                    size: 20,
                  ),
                  onPressed: () => textController.clear(),
                ),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (v) => controller.searchRepos(v),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(child: Obx(() => _body(controller, scrollController))),
        ],
      ),
    );
  }

  Widget _body(RepoSearchController c, ScrollController sc) {
    if (c.isLoading.value) return const LoadingWidget();
    if (c.errorMessage.isNotEmpty && c.repositories.isEmpty) {
      return AppErrorWidget(message: c.errorMessage.value, onRetry: () => c.searchRepos(c.searchQuery.value));
    }
    if (c.repositories.isEmpty) return c.hasSearched.value ? _notFoundState() : _emptyState();
    return RefreshIndicator(onRefresh: () async => c.searchRepos(c.searchQuery.value),
      child: ListView.builder(controller: sc, padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        itemCount: c.repositories.length + (c.isLoadingMore.value ? 1 : 0),
        itemBuilder: (ctx, i) => i == c.repositories.length ? _loadingMore() : RepoCardWidget(repository: c.repositories[i])));
  }

  Widget _loadingMore() => const Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator(color: AppTheme.primaryColor)));

  Widget _notFoundState() => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Icon(Icons.search_off_rounded, size: 64, color: AppTheme.borderColor), const SizedBox(height: 16),
    const Text(AppStrings.dataNotFound, style: TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
    const SizedBox(height: 8), const Text(AppStrings.tryAnotherKeyword, style: TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
  ]));

  Widget _emptyState() => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: AppTheme.primaryColor.withAlpha(25), shape: BoxShape.circle),
      child: Icon(Icons.search_rounded, size: 56, color: AppTheme.primaryColor.withAlpha(150))),
    const SizedBox(height: 20),
    const Text(AppStrings.activity, style: TextStyle(color: AppTheme.textPrimary, fontSize: 17, fontWeight: FontWeight.bold)),
    const SizedBox(height: 8), const Text(AppStrings.typeKeyword, style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
  ]));
}

