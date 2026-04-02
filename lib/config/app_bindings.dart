import 'package:get/get.dart';
import 'package:github_explorer/controllers/detail_controller.dart';
import 'package:github_explorer/controllers/navigation_controller.dart';
import 'package:github_explorer/controllers/profile_controller.dart';
import 'package:github_explorer/controllers/search_controller.dart';

/// Binding untuk halaman utama (navigation bar)
/// Mendaftarkan NavigationController dan RepoSearchController
class MainNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<RepoSearchController>(() => RepoSearchController());
  }
}

/// Binding untuk halaman detail repository
class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController());
  }
}

/// Binding untuk halaman profil user
class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
