class CastModel {
  final String name;
  final String originalName;
  final double popularity;
  final String charactor;
  final String profilePath;

  CastModel({
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.charactor,
    required this.profilePath,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'] ?? 'unknown name',
      originalName: json['original_name'] ?? 'unknown name',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      charactor: json['character'] ?? "Unknown chractr",
      profilePath: json['profile_path'] ?? "",
    );
  }
}
