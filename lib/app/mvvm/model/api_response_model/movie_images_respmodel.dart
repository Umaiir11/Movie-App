class MovieImagesResponseModel {
  final int? id;
  final List<MovieImageItem>? results;

  MovieImagesResponseModel({
    this.id,
    this.results,
  });

  factory MovieImagesResponseModel.fromJson(Map<String, dynamic> json) {
    return MovieImagesResponseModel(
      id: json['id'],
      results: json['results'] != null
          ? List<MovieImageItem>.from(
          json['results'].map((x) => MovieImageItem.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "results": results?.map((x) => x.toJson()).toList(),
    };
  }
}

class MovieImageItem {
  final String? iso6391;
  final String? iso31661;
  final String? name;
  final String? key;
  final String? site;
  final int? size;
  final String? type;
  final bool? official;
  final String? publishedAt;
  final String? id;

  MovieImageItem({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });

  factory MovieImageItem.fromJson(Map<String, dynamic> json) {
    return MovieImageItem(
      iso6391: json['iso_639_1'],
      iso31661: json['iso_3166_1'],
      name: json['name'],
      key: json['key'],
      site: json['site'],
      size: json['size'],
      type: json['type'],
      official: json['official'],
      publishedAt: json['published_at'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "iso_639_1": iso6391,
      "iso_3166_1": iso31661,
      "name": name,
      "key": key,
      "site": site,
      "size": size,
      "type": type,
      "official": official,
      "published_at": publishedAt,
      "id": id,
    };
  }
}
