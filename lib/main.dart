import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_explorer/config/app_routes.dart';
import 'package:github_explorer/config/app_strings.dart';
import 'package:github_explorer/config/app_theme.dart';

void main() {
  runApp(const GithubExplorerApp());
}

class GithubExplorerApp extends StatelessWidget {
  const GithubExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.main,
      getPages: AppRoutes.pages,
    );
  }
}
