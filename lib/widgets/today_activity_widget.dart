import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_explorer/config/app_assets.dart';
import 'package:github_explorer/config/app_strings.dart';
import 'package:github_explorer/config/app_theme.dart';
import 'package:github_explorer/controllers/navigation_controller.dart';

class TodayActivityWidget extends StatelessWidget {
  const TodayActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Get.find<NavigationController>();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(padding: EdgeInsets.only(left: 20, top: 10, bottom: 5),
          child: Text(AppStrings.todayActivity, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
        Container(width: double.infinity, margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: AppTheme.surfaceColor, borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(image: AssetImage(AppAssets.design), fit: BoxFit.cover),
            boxShadow: [BoxShadow(color: const Color(0x1A000000), blurRadius: 4)]),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _header(), const SizedBox(height: 20),
            GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.0, mainAxisSpacing: 16, crossAxisSpacing: 10,
              children: [
                _stat(AppAssets.calorie, AppStrings.calorie, '2356', '1876 kcals', Colors.red, null),
                _stat(AppAssets.drink, AppStrings.drink, '3', '8 glasses', Colors.blue, null),
                _activityStat(nav),
                _stat(AppAssets.sleep, AppStrings.sleep, '4', '8 hours', Colors.purple, null),
            ]),
            const SizedBox(height: 20), _btn(), const SizedBox(height: 12), _footer(),
          ])),
    ]);
  }

  Widget _activityStat(NavigationController nav) => Obx(() {
    final act = nav.selectedActivity.value;
    String t = AppStrings.activity, v = '4578', tg = '5000 steps'; Color c = Colors.purple; IconData ic = Icons.directions_walk;
    if (act == AppStrings.run) { t = AppStrings.run; v = '3.2'; tg = '• 5km'; c = AppTheme.blueSoft; ic = Icons.directions_run; }
    else if (act == AppStrings.cycle) { t = AppStrings.cycle; v = '25'; tg = '• 45 mins'; c = AppTheme.levelColor; ic = Icons.directions_bike; }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      DropdownButtonHideUnderline(child: DropdownButton<String>(value: act, isDense: true, icon: Icon(Icons.expand_more, size: 16, color: c),
        selectedItemBuilder: (_) => [AppStrings.steps, AppStrings.run, AppStrings.cycle].map((e) => Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))).toList(),
        items: [AppStrings.steps, AppStrings.run, AppStrings.cycle].map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 12)))).toList(),
        onChanged: (val) => val != null ? nav.selectedActivity.value = val : null)),
      const SizedBox(height: 8),
      Row(children: [
        t == AppStrings.activity ? Image.asset(AppAssets.activity, width: 24, height: 24) : Icon(ic, size: 24, color: c),
        const SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: c.withAlpha(40), borderRadius: BorderRadius.circular(4)),
            child: Text(v, style: TextStyle(color: c, fontSize: 13, fontWeight: FontWeight.bold))),
          Text(tg, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 10)),
        ]),
      ]),
    ]);
  });

  Widget _header() => Row(children: [
    const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(AppStrings.overviewProgram, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        Text(AppStrings.overviewSub, style: TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
    ])),
    Image.asset(AppAssets.rightArrow, width: 24, height: 24, errorBuilder: (_, __, ___) => const Icon(Icons.chevron_right)),
  ]);

  Widget _stat(String img, String t, String v, String tg, Color c, IconData? ic) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SizedBox(height: 24, child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
    const SizedBox(height: 8),
    Row(children: [
      ic != null ? Icon(ic, size: 24, color: c) : Image.asset(img, width: 24, height: 24, errorBuilder: (_, __, ___) => Icon(Icons.error, size: 24, color: c)),
      const SizedBox(width: 8),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(v, style: TextStyle(color: c, fontSize: 13, fontWeight: FontWeight.bold)),
        Text(tg, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 10)),
      ]),
    ]),
  ]);

  Widget _btn() => SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {},
    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.blueSoft, foregroundColor: Colors.white, elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(vertical: 12)),
    child: const Text(AppStrings.start, style: TextStyle(fontWeight: FontWeight.bold))));

  Widget _footer() => Row(children: [
    Image.asset(AppAssets.seru, width: 20, height: 20, errorBuilder: (_, __, ___) => const Icon(Icons.info_outline, size: 20)),
    const SizedBox(width: 8),
    const Expanded(child: Text(AppStrings.recheckGoals, style: TextStyle(color: AppTheme.textSecondary, fontSize: 10))),
  ]);
}

