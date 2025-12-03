// ignore_for_file: non_constant_identifier_names

class WorkArea {
  final String id;
  final String title_ar;
  final String title_en;
  final String description_ar;
  final String description_en;
  final String image_url;

  WorkArea({
    required this.id,
    required this.title_ar,
    required this.title_en,
    required this.description_ar,
    required this.description_en,
    required this.image_url,
  });

  factory WorkArea.fromJson(Map<String, dynamic> json) {
    return WorkArea(
      id: json['id'],
      title_ar: json['title_ar'],
      title_en: json['title_en'],
      description_ar: json['description_ar'],
      description_en: json['description_en'],
      image_url: json['image'],
    );
  }
}
