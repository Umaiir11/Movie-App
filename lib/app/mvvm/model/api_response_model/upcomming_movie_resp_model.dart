

import 'package:tmdb_assignment/app/config/app_urls.dart';

class MovieResponse {
  final Dates? dates;
  final int? page;
  final List<Movie>? results;
  final int? totalPages;
  final int? totalResults;

  MovieResponse({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return MovieResponse();

    return MovieResponse(
      dates: json['dates'] != null ? Dates.fromJson(json['dates']) : null,
      page: json['page'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int?,
      totalResults: json['total_results'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dates': dates?.toJson(),
      'page': page,
      'results': results?.map((e) => e.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}

class Dates {
  final String? maximum;
  final String? minimum;

  Dates({this.maximum, this.minimum});

  factory Dates.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Dates();
    return Dates(
      maximum: json['maximum'] as String?,
      minimum: json['minimum'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maximum': maximum,
      'minimum': minimum,
    };
  }
}

class Movie {
  final int? id;
  final String? title;
  final String? originalTitle;
  final String? overview;
  final String? releaseDate;
  final String? posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final int? voteCount;
  final double? popularity;
  final bool? adult;
  final bool? video;
  final List<int>? genreIds;
  final String? originalLanguage;

  Movie({
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.releaseDate,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.voteCount,
    this.popularity,
    this.adult,
    this.video,
    this.genreIds,
    this.originalLanguage,
  });

  /// ✅ Computed Getters for Full Image URLs
  String get posterFullUrl {
    if (posterPath == null) return "";
    return "${AppUrls.imageBaseURL}${AppUrls.defaultImageSize}$posterPath";
  }

  String get backdropFullUrl {
    if (backdropPath == null) return "";
    return "${AppUrls.imageBaseURL}${AppUrls.defaultImageSize}$backdropPath";
  }

  factory Movie.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Movie();

    return Movie(
      id: json['id'] as int?,
      title: json['title'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      releaseDate: json['release_date'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      adult: json['adult'] as bool?,
      video: json['video'] as bool?,
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      originalLanguage: json['original_language'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'release_date': releaseDate,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'popularity': popularity,
      'adult': adult,
      'video': video,
      'genre_ids': genreIds,
      'original_language': originalLanguage,
    };
  }
}
