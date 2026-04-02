import 'package:get/get.dart';
import 'package:github_explorer/config/app_bindings.dart';
import 'package:github_explorer/views/detail_page.dart';
import 'package:github_explorer/views/main_nav_page.dart';
import 'package:github_explorer/views/profile_page.dart';
import 'package:github_explorer/views/search_page.dart';

class AppRoutes {
  static const String main = '/';
  static const String detail = '/detail';
  static const String profile = '/profile';
  static const String search = '/search';

  static final List<GetPage> pages = [
    GetPage(name: main, page: () => const MainNavPage(), binding: MainNavBinding()),
    GetPage(name: detail, page: () => const DetailPage(), binding: DetailBinding()),
    GetPage(name: profile, page: () => const ProfilePage(), binding: ProfileBinding()),
    GetPage(name: search, page: () => const SearchPage(), binding: MainNavBinding()),
  ];
}
