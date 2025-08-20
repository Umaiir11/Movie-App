import 'dart:convert';

import '../config/app_urls.dart';
import '../mvvm/model/api_response_model/api_response.dart';
import '../mvvm/model/api_response_model/movie_details_respmodel.dart';
import '../mvvm/model/api_response_model/movie_images_respmodel.dart';
import '../mvvm/model/api_response_model/movie_trailer_respmodel.dart';
import '../mvvm/model/api_response_model/upcomming_movie_resp_model.dart';
import '../services/api_response_handler.dart';
import '../services/https_calls.dart';

class MovieRepo {
  Future<ApiResponse<MovieResponse>> getUpcomingMovies() async {
    try {
      String? endPoint = AppUrls.upComingMovies+AppUrls.apikey;
      final response = await HttpsCalls().getApiHits(endPoint);
      return await ApiResponseHandler.process(response, endPoint, (dataJson) => MovieResponse.fromJson(dataJson));
    } catch (e, stackTrace) {
      ApiResponseHandler.logUnhandledError(e, stackTrace);
      rethrow;
    }
  }


  Future<ApiResponse<MovieDetails>> getMovieDetails(int movieId) async {
    try {
      String? endPoint = AppUrls.movieDetails+movieId.toString()+AppUrls.apikey;
      final response = await HttpsCalls().getApiHits(endPoint);
      return await ApiResponseHandler.process(response, endPoint, (dataJson) => MovieDetails.fromJson(dataJson));
    } catch (e, stackTrace) {
      ApiResponseHandler.logUnhandledError(e, stackTrace);
      rethrow;
    }
  }
  Future<ApiResponse<MovieVideosResponse>> getMovieTrailer(int movieId) async {
    try {
      String endPoint = "${AppUrls.movieTrailer}$movieId/videos${AppUrls.apikey}";
      final response = await HttpsCalls().getApiHits(endPoint);
      return await ApiResponseHandler.process(response, endPoint, (dataJson) => MovieVideosResponse.fromJson(dataJson));
    } catch (e, stackTrace) {
      ApiResponseHandler.logUnhandledError(e, stackTrace);
      rethrow;
    }
  }
  Future<ApiResponse<MovieImagesResponseModel>> getMovieTImages(int movieId) async {
    try {
      String? endPoint = AppUrls.movieImages+movieId.toString()+AppUrls.apikey;
      final response = await HttpsCalls().getApiHits(endPoint);
      return await ApiResponseHandler.process(response, endPoint, (dataJson) => MovieImagesResponseModel.fromJson(dataJson));
    } catch (e, stackTrace) {
      ApiResponseHandler.logUnhandledError(e, stackTrace);
      rethrow;
    }
  }


}
