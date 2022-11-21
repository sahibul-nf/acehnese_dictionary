import 'package:acehnese_dictionary/app/features/dictionary/models/word.dart';

class GetAllWordsModel {
  GetAllWordsModel({
    required this.totalData,
    required this.words,
  });

  final int totalData;
  final List<Word> words;

  factory GetAllWordsModel.fromJson(Map<String, dynamic> json) =>
      GetAllWordsModel(
        totalData: json["total_data"],
        words: List<Word>.from(json["words"].map((x) => Word.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_data": totalData,
        "words": List<dynamic>.from(words.map((x) => x.toJson())),
      };
}
