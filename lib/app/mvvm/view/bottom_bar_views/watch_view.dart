import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:tmdb_assignment/app/config/app_assets.dart';
import 'package:tmdb_assignment/app/config/app_colors.dart';
import 'package:tmdb_assignment/app/config/app_routes.dart';
import 'package:tmdb_assignment/app/config/app_text_style.dart';
import 'package:tmdb_assignment/app/config/padding_extensions.dart';
import 'package:tmdb_assignment/app/config/sizedbox_extension.dart';
import 'package:tmdb_assignment/app/customWidgets/custom_cache_image/custom_cached_image.dart';
import '../../view_model/watch_controller/watch_controler.dart';

class WatchView extends StatefulWidget {
  const WatchView({super.key});

  @override
  State<WatchView> createState() => _WatchViewState();
}

class _WatchViewState extends State<WatchView> {
  final WatchController _watchController = Get.find();


  List<String> imagesList = [
    "https://images.pexels.com/photos/2752776/pexels-photo-2752776.jpeg",
    "https://images.pexels.com/photos/5852135/pexels-photo-5852135.jpeg",
    "https://images.pexels.com/photos/8104844/pexels-photo-8104844.jpeg",
  ];

  List<String> assetList = [
    AppAssets.comediesImg,
    AppAssets.crimeImg,
    AppAssets.familyImg,
    AppAssets.documentriesImg,
    AppAssets.dramasImg,
    AppAssets.fantasyImg,
    AppAssets.holidaysImg,
    AppAssets.horrorImg,
    AppAssets.scifiImg,
    AppAssets.thrillerImg,
  ];

  List<String> titles = ["Netflix Seasons", "You Season", "La Casa Se Papel"];
  List<String> assetTitles = ["Comedies", "Crime", "Family", "Documentaries", "Dramas", "Fantasy", "Holidays", "Horror", "Sci-Fi", "Thriller"];

  @override
  void initState() {
    // TODO: implement initState
    _watchController.fetchUpcomingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F6),
      body: Column(
        children: [
          // --- Top AppBar / Search Row ---
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xffEFEFEF))),
            ),
            child: Obx(() {
              return _watchController.isSearched.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _watchController.isSearched.value = false;
                          },
                          child: Icon(Icons.arrow_back_ios_new_rounded, size: 25.sp, color: Colors.black),
                        ),
                        10.w.width,
                        Text(
                          '3 Results were Found',
                          style: AppTextStyles.customText16(color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ).paddingHorizontal(15.w).paddingTop(50.h).paddingBottom(20.h)
                  : Obx(() {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        child: _watchController.isSearching.value
                            ? TextField(
                                    key: const ValueKey("searchField"),
                                    autofocus: true,
                                    onSubmitted: (val) {
                                      _watchController.isSearched.value = true;
                                      _watchController.isSearching.value = false;
                                    },
                                    style: AppTextStyles.customText16(color: Colors.black),
                                    decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: () => _watchController.isSearching.value = false,
                                        child: Icon(Icons.close, color: Colors.black, size: 25.sp),
                                      ),
                                      prefixIcon: Icon(Icons.search, color: Colors.black, size: 25.sp),
                                      hintText: "Search...",
                                      hintStyle: AppTextStyles.customText16(color: Colors.grey),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50.sp),
                                        borderSide: const BorderSide(color: Color(0xffEFEFEF)),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xffF2F2F6),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50.sp),
                                        borderSide: const BorderSide(color: Color(0xffEFEFEF)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50.sp),
                                        borderSide: BorderSide(color: AppColors.primary),
                                      ),
                                    ),
                                  )
                                  .paddingHorizontal(15.w)
                                  .paddingTop(50.h)
                                  .paddingBottom(20.h)
                                  // Animate when it appears
                                  .animate()
                                  .fadeIn(duration: 400.ms, curve: Curves.easeOut)
                                  .slideY(begin: -0.3, end: 0, duration: 400.ms, curve: Curves.easeOut)
                            : Row(
                                    key: const ValueKey("titleRow"),
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Watch',
                                        style: AppTextStyles.customText18(color: Colors.black, fontWeight: FontWeight.w500),
                                      ),
                                      GestureDetector(
                                        onTap: () => _watchController.isSearching.value = true,
                                        child: Icon(Icons.search, color: Colors.black, size: 25.sp),
                                      ),
                                    ],
                                  )
                                  .paddingHorizontal(15.w)
                                  .paddingTop(50.h)
                                  .paddingBottom(20.h)
                                  .animate()
                                  .fadeIn(duration: 400.ms)
                                  .slideY(begin: -0.3, end: 0, duration: 400.ms),
                      );
                    });
            }),
          ),
          20.h.height,
          Obx(() {
            return _watchController.isSearched.value
                ? Expanded(
                    child: ListView.builder(
                      itemCount: imagesList.length,
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _buildSearchTile(
                              imgPath: imagesList[index],
                              title: titles[index],
                              onTap: () {
                                Get.toNamed(AppRoutes.movieDetailView);
                              },
                              category: 'Fantasy',
                            )
                            .paddingBottom(12.h)
                            .animate(delay: (100 * index).ms)
                            .fadeIn(duration: 500.ms, curve: Curves.easeOut)
                            .slideY(begin: 0.2, end: 0, duration: 500.ms, curve: Curves.easeOut)
                            .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1), duration: 500.ms, curve: Curves.easeOut);
                      },
                    ).paddingHorizontal(15.w),
                  )
                : Obx(() {
                    return _watchController.isSearching.value
                        ? Expanded(
                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 120.h,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                              ),
                              itemCount: assetList.length,
                              padding: EdgeInsets.zero,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return _buildWatchTile(
                                      imgPath: assetList[index],
                                      title: assetTitles[index],
                                      onTap: () {
                                        Get.toNamed(AppRoutes.movieDetailView);
                                      },
                                      isAsset: true,
                                      height: 120.h,
                                    )
                                    // Animate each item with stagger
                                    .animate(delay: (100 * index).ms)
                                    .fadeIn(duration: 500.ms, curve: Curves.easeOut)
                                    .slideY(begin: 0.2, end: 0, duration: 500.ms, curve: Curves.easeOut)
                                    .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1), duration: 500.ms, curve: Curves.easeOut);
                              },
                            ).paddingHorizontal(15.w),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: imagesList.length,
                              padding: EdgeInsets.zero,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return _buildWatchTile(
                                      imgPath: imagesList[index],
                                      title: titles[index],
                                      onTap: () {
                                        Get.toNamed(AppRoutes.movieDetailView);
                                      },
                                    )
                                    .paddingBottom(12.h)
                                    // Animate each item with stagger
                                    .animate(delay: (100 * index).ms)
                                    .fadeIn(duration: 500.ms, curve: Curves.easeOut)
                                    .slideY(begin: 0.2, end: 0, duration: 500.ms, curve: Curves.easeOut)
                                    .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1), duration: 500.ms, curve: Curves.easeOut);
                              },
                            ).paddingHorizontal(15.w),
                          );
                  });
          }),
        ],
      ),
    );
  }

  Widget _buildWatchTile({required imgPath, required title, required VoidCallback onTap, double? height, bool? isAsset = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          isAsset ?? false
              ? Image.asset(imgPath, height: height)
              : CustomCachedImage(height: height ?? 200.h, width: double.infinity, imageUrl: imgPath, borderRadius: 14.sp),
          Positioned(
            bottom: 15.h,
            left: 10.w,
            child:
                Text(
                      title,
                      style: AppTextStyles.customText18(color: Colors.white, fontWeight: FontWeight.w500),
                    )
                    // Animate the text separately with a little slide up
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTile({required imgPath, required title, required VoidCallback onTap, required category}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomCachedImage(height: 100.sp, width: 100.sp, imageUrl: imgPath, borderRadius: 14.sp),
              20.w.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.customText16(color: Colors.black, fontWeight: FontWeight.w500),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut),
                  3.h.height,
                  Text(
                    category,
                    style: AppTextStyles.customText14(color: AppColors.textLightBlack.withOpacity(0.5), fontWeight: FontWeight.w400),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut),
                ],
              ),
            ],
          ),
          Icon(Icons.more_horiz_outlined, size: 25.sp, color: Colors.lightBlue),
        ],
      ),
    );
  }
}
