import 'package:hive/hive.dart';
part 'movie_model.g.dart';

@HiveType(typeId: 0)
class MovieModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String posterPath;

  @HiveField(3)
  final double voteAverage;

  @HiveField(4)
  final String overview;

  @HiveField(5)
  final String backdropPath;

  @HiveField(6)
  final String releaseDate;

  MovieModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.overview,
    required this.releaseDate,
    required this.backdropPath,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? "No Title",
      posterPath: json['poster_path']?.toString() ?? "",
      voteAverage: (json['vote_average'] as num).toDouble() ,
      overview: json['overview']?.toString() ?? "No Description",
      releaseDate: json['release_date']?.toString() ?? "" ,
      backdropPath: json['backdrop_path']?.toString() ?? "" ,
    );
  }
}
