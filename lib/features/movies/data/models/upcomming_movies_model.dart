import 'package:movie_hive/core/utills/app_imports.dart';

class Dates {
  final String maximum;
  final String minimum;

  Dates({required this.maximum, required this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
      maximum: json['maximum']?.toString() ?? "",
      minimum: json['minimum']?.toString() ?? "",
    );
  }
}

class UpcommingMoviesModel {
  final Dates dates;
  final List<MovieModel> movies;
  final int page;
  final int totalPages;

  UpcommingMoviesModel({
    required this.dates,
    required this.movies,
    required this.page,
    required this.totalPages,
  });

  factory UpcommingMoviesModel.formJson(Map<String, dynamic> json) {
    return UpcommingMoviesModel(
      dates: Dates.fromJson(json['dates']),
      movies: (json['results'] as List)
          .map((e) => MovieModel.fromJson(e))
          .toList(),
      page: json['page'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
    );
  }
}
