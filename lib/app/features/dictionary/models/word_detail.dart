class WordDetail {
  WordDetail({
    this.id,
    this.aceh,
    this.indonesia,
    this.english,
    this.imagesUrl,
  });

  final int? id;
  final String? aceh;
  final String? indonesia;
  final String? english;
  final List<String>? imagesUrl;

  factory WordDetail.fromJson(Map<String, dynamic> json) => WordDetail(
        id: json["id"],
        aceh: json["aceh"],
        indonesia: json["indonesia"],
        english: json["english"],
        imagesUrl: List<String>.from(json["images_url"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "aceh": aceh,
        "indonesia": indonesia,
        "english": english,
        "images_url": List<dynamic>.from(imagesUrl!.map((x) => x)),
      };
}
