class Api {
  static String herokuBaseUrl = 'https://aceh-dictionary.herokuapp.com/api/v1';
  static String railwayBaseUrl =
      'https://web-production-2a5f.up.railway.app/api/v1';
  static String baseUrl = railwayBaseUrl;
}

class ApiPath {
  static String getAllWords() => '/dictionaries';
  static String getWordDetail(int id) => '/dictionaries/$id';
  static String searchWord(String query, String algorithm) =>
      '/search?q=$query&algorithm=$algorithm';

  // users
  static String signUp() => '/users';
  static String signIn() => '/users/sessions';
  static String authCheck() => '/users';

  // bookmarks
  static String getBookmarks() => '/bookmarks';
  static String getMarkedWord() => '/bookmark';
  static String addWordToBookmark() => '/bookmarks';
  static String removeAllBookmark() => '/bookmarks';
}

abstract class ApiResponseInterface {
  final int statusCode;
  final String message;
  final String? errors;
  final dynamic data;

  ApiResponseInterface({
    required this.message,
    required this.statusCode,
    this.errors,
    this.data,
  });
}

class ApiResponse {
  ApiResponse({
    required this.meta,
    this.errors,
    required this.data,
  });

  final Meta meta;
  final dynamic errors;
  final dynamic data;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        meta: Meta.fromJson(json["meta"]),
        errors: json["errors"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "errors": errors,
        "data": data,
      };
}

class Meta {
  Meta({
    required this.message,
    required this.code,
    required this.status,
  });

  final String message;
  final int code;
  final String status;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json["message"],
        code: json["code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "status": status,
      };
}
