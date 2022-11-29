// To parse this JSON data, do
//
//     final bookmarksModel = bookmarksModelFromJson(jsonString);

import 'dart:convert';

import 'package:acehnese_dictionary/app/features/dictionary/models/word.dart';

Bookmarks bookmarksModelFromJson(String str) =>
    Bookmarks.fromJson(json.decode(str));

String bookmarksModelToJson(Bookmarks data) => json.encode(data.toJson());

class Bookmarks {
  Bookmarks({
    this.id,
    this.userId,
    this.word,
  });

  int? id;
  int? userId;
  Word? word;

  factory Bookmarks.fromJson(Map<String, dynamic> json) => Bookmarks(
        id: json["id"],
        userId: json["user_id"],
        word: Word.fromJson(json["dictionary"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "dictionary": word!.toJson(),
      };
}
