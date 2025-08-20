import 'package:get/get.dart';
import 'package:tmdb_assignment/app/repository/movie_repo.dart';

import '../../../services/logger_service.dart';
import '../../model/api_response_model/api_response.dart';
import '../../model/api_response_model/upcomming_movie_resp_model.dart';

class WatchController extends GetxController {
  RxBool isSearching = false.obs;
  RxBool isSearched = false.obs;
  RxBool isUpcomingMoviesLoading = false.obs;

  RxList<Movie> upcomingMovies = <Movie>[].obs;

  Future<void> fetchUpcomingMovies() async {
    try {
      isUpcomingMoviesLoading.value = true;
      upcomingMovies.clear();

      ApiResponse<MovieResponse>? apiResponse = await MovieRepo().getUpcomingMovies();
      upcomingMovies.assignAll(apiResponse.data?.results ?? []);

      LoggerService.i(' All upComing Movies  fetched: ${upcomingMovies.length}');
    } catch (e, stack) {
      LoggerService.e(' allDrivers API error', error: e, stackTrace: stack);
    } finally {
      isUpcomingMoviesLoading.value = false;
    }
  }
}
