class AuthModel {
  AuthModel({
    this.token,
  });

  final String? token;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
