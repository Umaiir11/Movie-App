import 'package:tmdb_assignment/app/config/app_urls.dart';

class MovieDetails {
  final bool? adult;
  final String? backdropPath;
  final BelongsToCollection? belongsToCollection;
  final int? budget;
  final List<Genre>? genres;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompany>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final String? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  MovieDetails({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originCountry,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  /// ✅ Full image URL getters
  String get posterFullUrl {
    if (posterPath == null) return "";
    return "${AppUrls.imageBaseURL}${AppUrls.defaultImageSize}$posterPath";
  }

  String get backdropFullUrl {
    if (backdropPath == null) return "";
    return "${AppUrls.imageBaseURL}${AppUrls.defaultImageSize}$backdropPath";
  }

  factory MovieDetails.fromJson(Map<String, dynamic>? json) {
    if (json == null) return MovieDetails();

    return MovieDetails(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      belongsToCollection: json['belongs_to_collection'] != null
          ? BelongsToCollection.fromJson(json['belongs_to_collection'])
          : null,
      budget: json['budget'] as int?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e))
          .toList(),
      homepage: json['homepage'] as String?,
      id: json['id'] as int?,
      imdbId: json['imdb_id'] as String?,
      originCountry: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      productionCompanies: (json['production_companies'] as List<dynamic>?)
          ?.map((e) => ProductionCompany.fromJson(e))
          .toList(),
      productionCountries: (json['production_countries'] as List<dynamic>?)
          ?.map((e) => ProductionCountry.fromJson(e))
          .toList(),
      releaseDate: json['release_date'] as String?,
      revenue: json['revenue'] as int?,
      runtime: json['runtime'] as int?,
      spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
          ?.map((e) => SpokenLanguage.fromJson(e))
          .toList(),
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'belongs_to_collection': belongsToCollection?.toJson(),
      'budget': budget,
      'genres': genres?.map((e) => e.toJson()).toList(),
      'homepage': homepage,
      'id': id,
      'imdb_id': imdbId,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'production_companies': productionCompanies?.map((e) => e.toJson()).toList(),
      'production_countries': productionCountries?.map((e) => e.toJson()).toList(),
      'release_date': releaseDate,
      'revenue': revenue,
      'runtime': runtime,
      'spoken_languages': spokenLanguages?.map((e) => e.toJson()).toList(),
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}

class BelongsToCollection {
  final int? id;
  final String? name;
  final String? posterPath;
  final String? backdropPath;

  BelongsToCollection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  /// ✅ Full URL getters
  String get posterFullUrl {
    if (posterPath == null) return "";
    return "${AppUrls.imageBaseURL}${AppUrls.defaultImageSize}$posterPath";
  }

  String get backdropFullUrl {
    if (backdropPath == null) return "";
    return "${AppUrls.imageBaseURL}${AppUrls.defaultImageSize}$backdropPath";
  }

  factory BelongsToCollection.fromJson(Map<String, dynamic>? json) {
    if (json == null) return BelongsToCollection();
    return BelongsToCollection(
      id: json['id'] as int?,
      name: json['name'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
    };
  }
}

class Genre {
  final int? id;
  final String? name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Genre();
    return Genre(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class ProductionCompany {
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  ProductionCompany({this.id, this.logoPath, this.name, this.originCountry});

  /// ✅ Full URL getter
  String get logoFullUrl {
    if (logoPath == null) return "";
    return "${AppUrls.imageBaseURL}${AppUrls.defaultImageSize}$logoPath";
  }

  factory ProductionCompany.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ProductionCompany();
    return ProductionCompany(
      id: json['id'] as int?,
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String?,
      originCountry: json['origin_country'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'logo_path': logoPath,
    'name': name,
    'origin_country': originCountry,
  };
}

class ProductionCountry {
  final String? iso31661;
  final String? name;

  ProductionCountry({this.iso31661, this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ProductionCountry();
    return ProductionCountry(
      iso31661: json['iso_3166_1'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'iso_3166_1': iso31661,
    'name': name,
  };
}

class SpokenLanguage {
  final String? englishName;
  final String? iso6391;
  final String? name;

  SpokenLanguage({this.englishName, this.iso6391, this.name});

  factory SpokenLanguage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return SpokenLanguage();
    return SpokenLanguage(
      englishName: json['english_name'] as String?,
      iso6391: json['iso_639_1'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'english_name': englishName,
    'iso_639_1': iso6391,
    'name': name,
  };
}
