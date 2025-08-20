abstract class AppUrls {
  AppUrls._();

  static const String baseAPIURL = 'https://api.themoviedb.org/';
  static const String apikey = "?api_key=5f60a6a4cf5fc281862cc7f6df2e74a5";

  static const String imageBaseURL = 'https://image.tmdb.org/t/p/';
  static const String defaultImageSize = 'w500';

 //movie app endpoints
  static const String upComingMovies = '3/movie/upcoming';
  static const String movieDetails = '3/movie/';
  static const String movieTrailer = '3/movie/';
  static const String movieImages = '3/movie/';


}