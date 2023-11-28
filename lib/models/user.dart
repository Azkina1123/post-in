part of "models.dart";

<<<<<<< HEAD
class Userdata {
  // int id;
  String? docId;
=======
class User {
  String id;
>>>>>>> 2b419a6060db0d4032fc8d2e598e46631d0bfd37
  DateTime tglDibuat;
  String username;
  String namaLengkap;
  String email;
  String noTelp;
  String gender;
  String password;
  String? foto;
  String? sampul;

<<<<<<< HEAD
  Userdata({
    // required this.id,
    this.docId,
=======
  List<String> followings = [];

  User({
    required this.id,
>>>>>>> 2b419a6060db0d4032fc8d2e598e46631d0bfd37
    required this.tglDibuat,
    required this.username,
    required this.namaLengkap,
    required this.email,
    required this.noTelp,
    required this.gender,
    required this.password,
    this.foto,
    this.sampul,
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
