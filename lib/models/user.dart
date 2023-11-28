part of "models.dart";

class User {
  String id;
  DateTime tglDibuat;
  String username;
  String namaLengkap;
  String email;
  String noTelp;
  String gender;
  String password;
  String foto;
  String sampul;

  List<String> followings = [];

  User({
    required this.id,
    required this.tglDibuat,
    required this.username,
    required this.namaLengkap,
    required this.email,
    required this.noTelp,
    required this.gender,
    required this.password,
    required this.foto,
    required this.sampul,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    User user = User(
      id: json["id"].toString(),
      tglDibuat: json["tglDibuat"].toDate(),
      username: json["username"],
      namaLengkap: json["namaLengkap"],
      email: json["email"],
      gender: json["gender"],
      noTelp: json["noTelp"],
      sampul: json["sampul"],
      password: json["password"],
      foto: json["foto"],
    );
    user.followings = List<String>.from(json["followings"]);

    return user;
  }
}
