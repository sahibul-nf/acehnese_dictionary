class Bookmark {
  Bookmark({
    this.id,
    this.userId,
    this.dictionaryId,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? userId;
  final int? dictionaryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        id: json["id"],
        userId: json["user_id"],
        dictionaryId: json["dictionary_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "dictionary_id": dictionaryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
