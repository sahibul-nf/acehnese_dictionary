class Word {
  final int id;
  final String aceh;
  final String? indonesia;
  final String? english;
  final String? imageUrl;

  Word({required this.id, required this.aceh, this.indonesia, this.english, this.imageUrl});

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'],
      aceh: json['aceh'],
      indonesia: json['indonesia'],
      english: json['english'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aceh': aceh,
      'indonesia': indonesia,
      'english': english,
      'image_url': imageUrl,
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['id'],
      aceh: map['aceh'],
      indonesia: map['indonesia'],
      english: map['english'],
      imageUrl: map['image_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'aceh': aceh,
      'indonesia': indonesia,
      'english': english,
      'image_url': imageUrl,
    };
  }
}
