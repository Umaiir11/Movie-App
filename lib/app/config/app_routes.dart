import 'package:get/get.dart';
import 'package:tmdb_assignment/app/mvvm/view/bottom_bar_view/bottom_bar_view.dart';
import 'package:tmdb_assignment/app/mvvm/view/movie_detail_view/movie_detail_view.dart';
import 'package:tmdb_assignment/app/mvvm/view/ticket_view.dart';
import 'package:tmdb_assignment/app/mvvm/view_model/bottom_bar_controller/bottom_bar_controller.dart';
import 'package:tmdb_assignment/app/mvvm/view_model/ticket_controller.dart';
import 'package:tmdb_assignment/app/mvvm/view_model/watch_controller/watch_controler.dart';

import '../mvvm/view/splash_view/splash_view.dart';
import '../mvvm/view_model/movie_details_controller.dart';

/// Defines navigation routes for the LayerX app.
abstract class AppRoutes {
  AppRoutes._();

  static const splashView = '/splashView';
  static const bottomBarView = '/bottomBarView';
  static const movieDetailView = '/movieDetailView';
  static const ticketView = '/ticketView';
}

abstract class AppPages {
  AppPages._();

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.splashView,
      page: () => SplashView(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.ticketView,
      page: () => TheaterScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<TheaterController>(() => TheaterController());
      }),
    ),
    GetPage(
      name: AppRoutes.movieDetailView,
      page: () => MovieDetailView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MovieDetailsController>(() => MovieDetailsController());
      }),
    ),
    GetPage(
      name: AppRoutes.bottomBarView,
      page: () => BottomBarView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<BottomBarController>(() => BottomBarController());
        Get.lazyPut<WatchController>(() => WatchController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 600),
    ),
  ];
}
