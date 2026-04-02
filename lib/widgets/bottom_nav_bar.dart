import 'package:flutter/material.dart';
import 'package:github_explorer/config/app_assets.dart';
import 'package:github_explorer/config/app_theme.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onFabPressed;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onFabPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final totalHeight = 77 + bottomPadding;
    return SizedBox(
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: totalHeight,
            decoration: const BoxDecoration(
              color: AppTheme.surfaceColor,
              border: Border(top: BorderSide(color: AppTheme.borderColor)),
            ),
            padding: EdgeInsets.only(
              left: 14,
              right: 14,
              bottom: bottomPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildItem('Home', 0),
                _buildItem('Social', 1),
                const SizedBox(width: 60),
                _buildItem('Event', 2),
                _buildItem('Reward', 3),
              ],
            ),
          ),
          Positioned(
            top: -30,
            left: 0,
            right: 0,
            child: Center(child: _buildFab()),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String label, int index) {
    final isActive = currentIndex == index;
    final color = isActive ? AppTheme.primaryColor : AppTheme.textSecondary;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            label == 'Home'
                ? Icon(Icons.home_rounded, color: color, size: 24)
                : Image.asset(
                    index == 1 ? AppAssets.social : (index == 2 ? AppAssets.event : AppAssets.reward),
                    width: 24,
                    height: 24,
                    color: color,
                  ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFab() {
    return GestureDetector(
      onTap: onFabPressed,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0x1A000000),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(AppAssets.button, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
