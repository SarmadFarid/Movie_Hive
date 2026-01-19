class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: json['id'] ?? 0, name: json['name'] ?? "");
  }
}

class ProductionCompany {
  final int id;
  final String name;
  final String logoPath;
  final String originCountry;

  ProductionCompany({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      logoPath: json['logo_path'] ?? "",
      originCountry: json['origin_country'] ?? "",
    );
  }
}

class SpokenLanguage {
  final String englishName;
  final String isoCode;

  SpokenLanguage({required this.englishName, required this.isoCode});
  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json['english_name'] ?? "",
      isoCode: json['iso_639_1'] ?? "",
    );
  }
}

class MovieDetailModel {
  final int id; //
  final String title;//
  final String posterPath;//
  final String overview;//
  final String backdropPath;//
  final String releaseDate;//
  final int runtime;
  final double voteAverage;//
  final int voteCount;
  final String status;
  final String tagline;
  final double budget;
  final double revenue;
  final double popularity; 
  final String homepage;
  final String originalLanguage;

  final List<Genre> genres;
  final List<ProductionCompany> productionCompanies;
  final List<SpokenLanguage> spokenLanguages;

  MovieDetailModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
    required this.status,
    required this.tagline,
    required this.budget,
    required this.revenue,
    required this.popularity, 
    required this.homepage,
    required this.originalLanguage,
    required this.genres,
    required this.productionCompanies,
    required this.spokenLanguages,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? " ",
      overview: json['overview'] ?? "",
      posterPath: json['poster_path'] ?? "",
      backdropPath: json['backdrop_path'] ?? "",
      releaseDate: json['release_date'] ?? "",
      runtime: json['runtime'] ?? 0,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      status: json['status'] ?? "",
      tagline: json['tagline'] ?? "",
      budget: (json['budget'] as num?)?.toDouble() ?? 0.0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      homepage: json['homepage'] ?? "",
      originalLanguage: json['original_language'] ?? "",
      genres:
          (json['genres'] as List?)?.map((e) => Genre.fromJson(e)).toList() ??
          [],
      productionCompanies:
          (json['production_companies'] as List?)
              ?.map((e) => ProductionCompany.fromJson(e))
              .toList() ??
          [],
      spokenLanguages:
          (json['spoken_languages'] as List?)
              ?.map((e) => SpokenLanguage.fromJson(e))
              .toList() ??
          [],
    );
  }
}
