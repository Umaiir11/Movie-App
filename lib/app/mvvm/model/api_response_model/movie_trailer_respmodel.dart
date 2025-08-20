class MovieVideosResponse {
  final int? id;
  final List<VideoItem>? results;

  MovieVideosResponse({
    this.id,
    this.results,
  });

  factory MovieVideosResponse.fromJson(Map<String, dynamic> json) {
    return MovieVideosResponse(
      id: json['id'],
      results: json['results'] != null
          ? List<VideoItem>.from(
          json['results'].map((x) => VideoItem.fromJson(x)))
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

// 📽️ VideoItem.dart

class VideoItem {
  final String? iso6391;
  final String? iso31661;
  final String? name;
  final String? key;
  final String? site;
  final int? size;
  final String? type;
  final bool? official;
  final DateTime? publishedAt;
  final String? id;

  VideoItem({
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

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(
      iso6391: json['iso_639_1'],
      iso31661: json['iso_3166_1'],
      name: json['name'],
      key: json['key'],
      site: json['site'],
      size: json['size'],
      type: json['type'],
      official: json['official'],
      publishedAt: json['published_at'] != null
          ? DateTime.tryParse(json['published_at'])
          : null,
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
      "published_at": publishedAt?.toIso8601String(),
      "id": id,
    };
  }

  /// 🎬 Direct YouTube Embed URL
  String get youtubeEmbedUrl {
    if (site?.toLowerCase() == "youtube" && key != null) {
      return "https://www.youtube.com/embed/$key";
    }
    return "";
  }
}
