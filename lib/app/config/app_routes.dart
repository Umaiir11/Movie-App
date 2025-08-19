import 'package:get/get.dart';
import 'package:tmdb_assignment/app/mvvm/view/bottom_bar_view/bottom_bar_view.dart';
import 'package:tmdb_assignment/app/mvvm/view_model/bottom_bar_controller/bottom_bar_controller.dart';
import 'package:tmdb_assignment/app/mvvm/view_model/watch_controller/watch_controler.dart';

import '../mvvm/view/splash_view/splash_view.dart';

/// Defines navigation routes for the LayerX app.
abstract class AppRoutes {
  AppRoutes._();

  static const splashView = '/splashView';
  static const bottomBarView = '/bottomBarView';
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
