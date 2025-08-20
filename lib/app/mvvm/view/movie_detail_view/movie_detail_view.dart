import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tmdb_assignment/app/config/padding_extensions.dart';
import 'package:tmdb_assignment/app/config/sizedbox_extension.dart';
import 'package:tmdb_assignment/app/customWidgets/custom_cache_image/custom_cached_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_text_style.dart';
import '../../model/api_response_model/movie_details_respmodel.dart';
import '../../view_model/movie_details_controller.dart';

class MovieDetailView extends StatefulWidget {
  const MovieDetailView({super.key});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  final MovieDetailsController _movieDetailsController = Get.find();
  int? movieId;

  @override
  void initState() {
    super.initState();
    movieId = Get.arguments is int ? Get.arguments : Get.arguments?.id;
    _movieDetailsController.fetchMovieDetails(movieId ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(() {
        if (_movieDetailsController.isMovieDetailsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final movie = _movieDetailsController.movieDetails.value;
        if (movie == null) {
          return const Center(child: Text('No movie details available'));
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(movie),
              _buildGenreSection(movie),
              _buildOverviewSection(movie),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeroSection(MovieDetails movie) {
    return Container(
      height: 0.6.sh,
      width: double.infinity,
      child: Stack(
        children: [
          CustomCachedImage(
            height: 0.6.sh,
            width: double.infinity,
            imageUrl: movie.backdropFullUrl,
            borderRadius: 0.sp,
            fit: BoxFit.cover,

                         ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(1.1, 1.1), end: const Offset(1.0, 1.0)),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildActionButtons(movie),
          ).paddingBottom(20.h),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: _circleButton(Icons.arrow_back_ios_new_rounded),
                ),
                10.w.width,
                Text(
                  movie.title ?? 'Watch',
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

  Widget _buildActionButtons(MovieDetails movie) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'In Theaters ${movie.releaseDate ?? 'Unknown Date'}',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250.w,
                height: 50.h,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    Get.dialog(
                      Dialog(
                        backgroundColor: Colors.black54,
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                      barrierDismissible: false,
                    );
                    try {
                      await _movieDetailsController.fetchMovieTrailer(movieId ?? 0);
                      Get.back(); // Close the loader
                      if (_movieDetailsController.yTLink?.isNotEmpty ?? false) {
                        Get.to(() => _VideoPlayerScreen(youtubeUrl: _movieDetailsController.yTLink?? ""));
                      } else {
                        Get.snackbar('Error', 'No trailer available', snackPosition: SnackPosition.BOTTOM);
                      }
                    } catch (e) {
                      Get.back(); // Close the loader on error
                      Get.snackbar('Error', 'Failed to load trailer: $e', snackPosition: SnackPosition.BOTTOM);
                    }
                  },
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

  Widget _buildGenreSection(MovieDetails movie) {
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
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: movie.genres?.asMap().entries.map((entry) {
              final index = entry.key;
              final genre = entry.value;
              return _buildGenreChip(genre.name ?? 'Unknown', _getGenreColor(index), index);
            }).toList() ??
                [],
          ),
        ],
      ),
    );
  }

  Color _getGenreColor(int index) {
    final colors = [
      Colors.teal,
      Colors.pinkAccent,
      Colors.deepPurple,
      CupertinoColors.systemYellow,
      Colors.blue,
      Colors.orange,
    ];
    return colors[index % colors.length];
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

  Widget _buildOverviewSection(MovieDetails movie) {
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
            movie.overview ?? 'No overview available',
            style: AppTextStyles.customText14(color: AppColors.textLightBlack.withOpacity(0.5), fontWeight: FontWeight.w400, height: 1.1),
          ).animate().slideY(begin: 0.3, duration: 600.ms).fadeIn(delay: 1300.ms),
          20.h.height,
        ],
      ),
    );
  }
}

class _VideoPlayerScreen extends StatefulWidget {
  final String youtubeUrl;

  const _VideoPlayerScreen({required this.youtubeUrl});

  @override
  State<_VideoPlayerScreen> createState() => __VideoPlayerScreenState();
}

class __VideoPlayerScreenState extends State<_VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        captionLanguage: 'en',
      ),
    )..addListener(() {
      if (_controller.value.playerState == PlayerState.ended) {
        Get.back();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.lightBlue,
              progressColors: const ProgressBarColors(
                playedColor: Colors.lightBlue,
                handleColor: Colors.lightBlueAccent,
              ),
              onReady: () {
                _controller.play();
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10.h,
            left: 16.w,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black.withOpacity(0.7),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp)),
              ),
              child: Text(
                'Done',
                style: AppTextStyles.customText16(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}