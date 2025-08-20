import 'package:get/get.dart';
import 'package:tmdb_assignment/app/repository/movie_repo.dart';

import '../../services/logger_service.dart';
import '../model/api_response_model/api_response.dart';
import '../model/api_response_model/movie_details_respmodel.dart';


class MovieDetailsController extends GetxController {
  RxBool isSearching = false.obs;
  RxBool isSearched = false.obs;
  RxBool isMovieDetailsLoading = false.obs;

  Rx<MovieDetails?> movieDetails = Rx<MovieDetails?>(null);

  Future<void> fetchMovieDetails(int movieId) async {
    try {
      isMovieDetailsLoading.value = true;
      movieDetails.value = null;

      ApiResponse<MovieDetails>? apiResponse = await MovieRepo().getMovieDetails(movieId);
      movieDetails.value = apiResponse.data;

      LoggerService.i(' Movie Details  fetched: ${movieDetails.value?.id}');
    } catch (e, stack) {
      LoggerService.e(' API error', error: e, stackTrace: stack);
    } finally {
      isMovieDetailsLoading.value = false;
    }
  }
}
