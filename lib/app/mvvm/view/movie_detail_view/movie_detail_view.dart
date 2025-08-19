import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tmdb_assignment/app/config/padding_extensions.dart';
import 'package:tmdb_assignment/app/config/sizedbox_extension.dart';
import 'package:tmdb_assignment/app/customWidgets/custom_cache_image/custom_cached_image.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_text_style.dart';

class MovieDetailView extends StatefulWidget {
  const MovieDetailView({super.key});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildHeroSection(), _buildGenreSection(), _buildOverviewSection()]),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 0.6.sh,
      width: double.infinity,
      child: Stack(
        children: [
          CustomCachedImage(
            height: 0.6.sh,
            width: double.infinity,
            imageUrl: 'https://images.pexels.com/photos/5852135/pexels-photo-5852135.jpeg',
            borderRadius: 0.sp,
          ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(1.1, 1.1), end: const Offset(1.0, 1.0)),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, AppColors.black.withOpacity(0.7), AppColors.black],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: _buildActionButtons()).paddingBottom(20.h),
          // Top Navigation
          Positioned(
            top: MediaQuery.of(context).padding.top + 10.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(onTap: () => Get.back(), child: _circleButton(Icons.arrow_back_ios_new_rounded)),
                10.w.width,
                Text(
                  'Watch',
                  style: AppTextStyles.customText18(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ],
            ).animate().slideY(begin: -1, duration: 600.ms).fadeIn(delay: 200.ms),
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      width: 40.w,
      height: 40.w,
      child: Icon(icon, color: AppColors.white, size: 20.sp),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'In Theaters December 22, 2021',
            style: AppTextStyles.customText18(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          10.h.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250.w,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
                    elevation: 0,
                  ),
                  child: Text(
                    'Get Tickets',
                    style: AppTextStyles.customText16(fontWeight: FontWeight.w600, color: AppColors.white),
                  ),
                ),
              ).animate().slideY(begin: 0.5, duration: 600.ms).fadeIn(delay: 600.ms).scale(begin: const Offset(0.9, 0.9)),
            ],
          ),

          12.h.height,

          // Watch Trailer Button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250.w,
                height: 50.h,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.play_arrow, color: AppColors.white, size: 20.sp),
                  label: Text(
                    'Watch Trailer',
                    style: AppTextStyles.customText16(color: AppColors.white, fontWeight: FontWeight.w500),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.lightBlue),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
                  ),
                ),
              ).animate().slideY(begin: 0.5, duration: 600.ms).fadeIn(delay: 700.ms).scale(begin: const Offset(0.9, 0.9)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenreSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          15.h.height,
          Text(
            'Genres',
            style: AppTextStyles.customText18(color: AppColors.black, fontWeight: FontWeight.w500),
          ).animate().slideX(begin: -0.3, duration: 500.ms).fadeIn(delay: 800.ms),

          12.h.height,

          Row(
            children: [
              _buildGenreChip('Action', Colors.teal, 0),
              8.w.width,
              _buildGenreChip('Thriller', Colors.pinkAccent, 1),
              8.w.width,
              _buildGenreChip('Science', Colors.deepPurple, 2),
              8.w.width,
              _buildGenreChip('Fiction', CupertinoColors.systemYellow, 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenreChip(String text, Color color, int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20.r)),
      child: Text(
        text,
        style: AppTextStyles.customText12(color: AppColors.white, fontWeight: FontWeight.w500),
      ),
    ).animate().slideY(begin: 0.3, duration: 400.ms).fadeIn(delay: Duration(milliseconds: 900 + (index * 100))).scale(begin: const Offset(0.8, 0.8));
  }

  Widget _buildOverviewSection() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          15.h.height,
          Text(
            'Overview',
            style: AppTextStyles.customText18(color: AppColors.black, fontWeight: FontWeight.w500),
          ).animate().slideX(begin: -0.3, duration: 500.ms).fadeIn(delay: 1200.ms),

          12.h.height,

          Text(
            'As A Collection Of History\'s Worst Tyrants And Criminal Masterminds Gather To Plot A War To Wipe Out Millions, One Man Must Race Against Time To Stop Them. Discover The Origins Of The Very First Independent Intelligence Agency In The King\'s Man. The Comic Book Secret Service By Mark Millar And Dave Gibbons.',
            style: AppTextStyles.customText14(color: AppColors.textLightBlack.withOpacity(0.5), fontWeight: FontWeight.w400, height: 1.1),
          ).animate().slideY(begin: 0.3, duration: 600.ms).fadeIn(delay: 1300.ms),

          20.h.height,
        ],
      ),
    );
  }
}
