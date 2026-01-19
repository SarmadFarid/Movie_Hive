class TrailerModel {
  final String id;
  final String publishTime;
  final String type;
  final bool official;
  final int size;
  final String site;
  final String key;
  final String name;
  final String isocode;

  TrailerModel({
    required this.id,
    required this.publishTime,
    required this.type,
    required this.official,
    required this.size,
    required this.isocode,
    required this.key,
    required this.name,
    required this.site,
  });

  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    return TrailerModel(
      id: json['id']?.toString() ?? "",
      publishTime: json['published_at']?.toString() ?? "",
      type: json['type']?.toString() ?? "",
      official: json['official'] ?? false,
      size: json['size'] ?? 0,
      isocode: json['iso_639_1']?.toString() ?? "",
      key: json['key']?.toString() ?? "",
      name: json['name']?.toString() ?? "",
      site: json['site']?.toString() ?? "",
    );
  }
}
