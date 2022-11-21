import 'dart:convert';

class Api {
  static String baseUrl = 'https://aceh-dictionary.herokuapp.com/api/v1';
  static ApiPath path = ApiPath();
}

class ApiPath {
  static String getAllWords() => '/dictionaries';
  static String getWord(int id) => '/dictionaries/$id';
  static String searchWord(String query) => '/search?q=$query';
}

abstract class ApiResponseInterface {
  final int statusCode;
  final String message;
  final dynamic errors;
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

  factory ApiResponse.fromJson(String str) =>
      ApiResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ApiResponse.fromMap(Map<String, dynamic> json) => ApiResponse(
        meta: Meta.fromMap(json["meta"]),
        errors: json["errors"],
        data: json["data"],
      );

  Map<String, dynamic> toMap() => {
        "meta": meta.toMap(),
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

  factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        message: json["message"],
        code: json["code"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "code": code,
        "status": status,
      };
}
