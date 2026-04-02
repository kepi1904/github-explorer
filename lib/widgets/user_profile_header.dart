import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_explorer/config/app_assets.dart';
import 'package:github_explorer/config/app_routes.dart';
import 'package:github_explorer/config/app_strings.dart';
import 'package:github_explorer/config/app_theme.dart';
import 'package:github_explorer/controllers/navigation_controller.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.find<NavigationController>();
    return Obx(() {
      final user = navCtrl.defaultUser.value;
      if (navCtrl.isLoadingUser.value || user == null) return _ph();
      return GestureDetector(onTap: () => Get.toNamed(AppRoutes.profile, arguments: user.login),
        child: Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20), margin: const EdgeInsets.only(top: 12),
          child: Row(children: [
            _avatarWithChip(), const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text((user.name ?? user.login).toUpperCase(), style: const TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2)),
                const Spacer(), _actions(),
              ]), const SizedBox(height: 8),
              _levelInfo(), const SizedBox(height: 8), _tag(),
            ])),
          ])));
    });
  }

  Widget _avatarWithChip() => Stack(alignment: Alignment.bottomCenter, clipBehavior: Clip.none, children: [
    Container(width: 82, height: 82, decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.avaBgColor),
      child: ClipOval(child: Image.asset(AppAssets.ava, width: 82, height: 82, fit: BoxFit.cover))),
    Positioned(bottom: -6, child: _ratingChip()),
  ]);

  Widget _ratingChip() => Container(width: 39, height: 23, padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
    decoration: BoxDecoration(color: AppTheme.yellowSoftColor, borderRadius: BorderRadius.circular(50), 
      boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 4, offset: const Offset(0, 2))]),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(AppAssets.chip, width: 12, height: 12), const SizedBox(width: 4),
      const Text('0', style: TextStyle(color: AppTheme.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
    ]));

  Widget _levelInfo() => Row(children: [
    const Text('Level 1', style: TextStyle(color: AppTheme.levelColor, fontSize: 13)),
    const SizedBox(width: 4), Container(width: 3, height: 3, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.textSecondary)),
    const SizedBox(width: 4), const Text('0', style: TextStyle(color: AppTheme.darkblueColor, fontSize: 13)),
  ]);

  Widget _tag() => Material(color: const Color(0xFFEFF9F9), borderRadius: BorderRadius.circular(12),
    child: const Padding(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Text(AppStrings.awakening, style: TextStyle(color: AppTheme.blueSoft, fontSize: 12, fontWeight: FontWeight.bold))));

  Widget _actions() => SizedBox(height: 24, child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
    Image.asset(AppAssets.download, width: 22, height: 22, color: AppTheme.textSecondary), const SizedBox(width: 8),
    Image.asset(AppAssets.pencil, width: 22, height: 22, color: AppTheme.blueSoft), const SizedBox(width: 25),
  ]));

  Widget _ph() => Container(width: 350, height: 82, margin: const EdgeInsets.only(left: 20, top: 12),
    child: Row(children: [
      Container(width: 82, height: 82, decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.borderColor.withAlpha(80))),
      const SizedBox(width: 14),
      Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
        children: [Container(width: 120, height: 16, color: AppTheme.borderColor.withAlpha(80)), const SizedBox(height: 8),
          Container(width: 80, height: 12, color: AppTheme.borderColor.withAlpha(60))])]));
}

