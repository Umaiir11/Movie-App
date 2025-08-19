import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_assignment/app/config/app_assets.dart';
import 'package:tmdb_assignment/app/config/app_colors.dart';
import 'package:tmdb_assignment/app/config/app_text_style.dart';
import 'package:tmdb_assignment/app/config/sizedbox_extension.dart';
import 'package:tmdb_assignment/app/mvvm/view/bottom_bar_views/watch_view.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({super.key});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text("Dashboard Screen", style: TextStyle(fontSize: 22))),
    const WatchView(),
    const Center(child: Text("Media Library Screen", style: TextStyle(fontSize: 22))),
    const Center(child: Text("More Screen", style: TextStyle(fontSize: 22))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> _icons = [AppAssets.dashboardIcon, AppAssets.watchIcon, AppAssets.libraryIcon, AppAssets.moreIcon];

  final List<String> _labels = ["DashBoard", "Watch", "Media Library", "More"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(begin: const Offset(0.1, 0), end: Offset.zero).animate(animation),
              child: child,
            ),
          );
        },
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, -3))],
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_icons.length, (index) {
              final isSelected = _selectedIndex == index;
              return GestureDetector(
                onTap: () => _onItemTapped(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(color: isSelected ? Colors.transparent : Colors.transparent, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(_icons[index], height: 20.h, color: isSelected ? Colors.white : Color(0xff827D88)),
                      8.h.height,
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: AppTextStyles.customText12(color: isSelected ? Colors.white : Colors.white70, fontWeight: FontWeight.w500),
                        child: Text(
                          _labels[index],
                          style: AppTextStyles.customText12(color: isSelected ? Colors.white : Colors.white70, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
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
