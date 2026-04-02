import 'package:flutter/material.dart';
import 'package:github_explorer/config/app_assets.dart';
import 'package:github_explorer/config/app_strings.dart';
import 'package:github_explorer/config/app_theme.dart';

class LogWeightWidget extends StatelessWidget {
  const LogWeightWidget({super.key});
  static const _data = [[50,38,36,10,2],[65,58,32,28,24],[88,62,45,38,29],[16,12,8,6,4],[70,65,50,45,12],[58,40,25,17,11],[80,68,62,10,3]];

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(padding: EdgeInsets.only(left: 20, top: 1, bottom: 5), child: Text(AppStrings.logWeight, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      Container(width: double.infinity, margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppTheme.surfaceColor, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: const Color(0x1A000000), blurRadius: 4)]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_info(), const SizedBox(height: 24), _chart(), const SizedBox(height: 8),
            _txt(AppStrings.dayPerWeek, 10, true), const SizedBox(height: 16), _legend(), const SizedBox(height: 16), _footer()])),
    ]);
  }

  Widget _info() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text(AppStrings.fatLoss, style: TextStyle(color: AppTheme.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
    const Text(AppStrings.weightTrackSub, style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
    const SizedBox(height: 14), Row(children: [_rt(AppStrings.weightLabel, '54.04 kg'), const Spacer(), _rt(AppStrings.lossLabel, '-0.0 kg')])]);

  Widget _rt(String l, String v) => RichText(text: TextSpan(style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13), children: [
        TextSpan(text: l), TextSpan(text: v, style: const TextStyle(color: AppTheme.blueSoft, fontWeight: FontWeight.bold))]));

  Widget _txt(String t, double s, bool b) => Center(child: Text(t, style: TextStyle(color: AppTheme.textSecondary, fontSize: s, fontWeight: b?FontWeight.bold:FontWeight.normal)));

  Widget _chart() => SizedBox(height: 170, child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
    Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: ['100', '80', '60', '40', '20', '0'].map((e) => Text(e, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 10))).toList()),
    const SizedBox(width: 10), Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.end, children: List.generate(7, (i) => _bar(i))))]));

  Widget _bar(int i) {
    final v = _data[i]; final cs = [const Color(0xFFCDAEF2), const Color(0xFFC2E999), const Color(0xFFF7CEC8), const Color(0xFF9FC9FA), const Color(0xFFFBE69A)];
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Container(width: 14, clipBehavior: Clip.antiAlias, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
        child: Column(children: List.generate(5, (idx) => Container(height: v[idx] * (140.0/262.0), color: cs[idx])))),
      const SizedBox(height: 8), Text('Day ${i + 1}', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 9))]);
  }

  Widget _legend() {
    final items = [(AppStrings.calorie, const Color(0xFFCDAEF2)), ('Protein', const Color(0xFFC2E999)), ('Carbohydrate', const Color(0xFFF7CEC8)), ('Fat', const Color(0xFF9FC9FA)), ('Fiber', const Color(0xFFFBE69A))];
    return Wrap(spacing: 12, runSpacing: 8, children: items.map((e) => Row(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(color: e.$2, shape: BoxShape.circle)), const SizedBox(width: 4),
      Text(e.$1, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 10))])).toList());
  }

  Widget _footer() => Row(children: [
    Image.asset(AppAssets.seru, width: 20, height: 20, errorBuilder: (_, __, ___) => const SizedBox()),
    const SizedBox(width: 8), const Expanded(child: Text(AppStrings.recheckGoals,
      style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontStyle: FontStyle.italic)))]);
}
