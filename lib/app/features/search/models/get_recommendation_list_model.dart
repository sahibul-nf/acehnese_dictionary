class RecommendationWordModel {
  final int id;
  final String aceh;
  final String indonesia;
  final String english;
  final double similiarity;

  RecommendationWordModel({
    required this.id,
    required this.aceh,
    required this.indonesia,
    required this.english,
    required this.similiarity,
  });

  factory RecommendationWordModel.fromJson(Map<String, dynamic> json) {
    return RecommendationWordModel(
      id: json['id'],
      aceh: json['aceh'],
      indonesia: json['indonesia'],
      english: json['english'],
      similiarity: json['similiarity'] == 1 ? 1.0 : json['similiarity'],
    );
  }
}
