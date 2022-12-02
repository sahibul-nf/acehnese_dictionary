import '../../dictionary/models/word.dart';

class Bookmark {
  Bookmark({
    this.id,
    this.userId,
    this.dictionaryId,
    this.word,
  });

  final int? id;
  final int? userId;
  final int? dictionaryId;
  final Word? word;

  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        id: json["id"],
        userId: json["user_id"],
        dictionaryId: json["dictionary_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "dictionary_id": dictionaryId,
      };
}
