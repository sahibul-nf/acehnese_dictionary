class AuthModel {
  AuthModel({
    this.id,
    this.name,
    this.email,
    this.token,
    this.avatarUrl,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? token;
  final String? avatarUrl;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        token: json["token"],
        avatarUrl: json["avatar_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "token": token,
        "avatar_url": avatarUrl,
      };
}
