import 'package:get/get.dart';
import 'package:tmdb_assignment/app/repository/movie_repo.dart';

import '../../services/logger_service.dart';
import '../model/api_response_model/api_response.dart';
import '../model/api_response_model/movie_details_respmodel.dart';
import '../model/api_response_model/movie_trailer_respmodel.dart';

class MovieDetailsController extends GetxController {
  RxBool isSearching = false.obs;
  RxBool isSearched = false.obs;
  RxBool isMovieDetailsLoading = false.obs;
  RxBool isTrailerLoading = false.obs;
  String? yTLink;

  Rx<MovieDetails?> movieDetails = Rx<MovieDetails?>(null);
  RxList<VideoItem> movieTrailer = <VideoItem>[].obs;

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

  Future<void> fetchMovieTrailer(int movieId) async {
    try {
      isTrailerLoading.value = true;
      movieTrailer.clear();

      ApiResponse<MovieVideosResponse>? apiResponse = await MovieRepo().getMovieTrailer(movieId);

      movieTrailer.value = apiResponse.data?.results ?? [];

      if (movieTrailer.isNotEmpty) {
        yTLink = movieTrailer.first.youtubeEmbedUrl;
        LoggerService.i('Movie Trailer URL: $yTLink');
      }

      LoggerService.i('Movie Trailer fetched for movieId: $movieId');
    } catch (e, stack) {
      LoggerService.e('API error', error: e, stackTrace: stack);
    } finally {
      isTrailerLoading.value = false;
    }
  }
}
