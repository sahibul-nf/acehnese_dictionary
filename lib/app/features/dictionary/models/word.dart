class Word {
  final int id;
  final String aceh;
  final String? indonesia;
  final String? english;

  Word({required this.id, required this.aceh, this.indonesia, this.english});

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'],
      aceh: json['aceh'],
      indonesia: json['indonesia'],
      english: json['english'],
    );
  }
}
