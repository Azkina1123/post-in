part of "models.dart";

class User {
  int id;
  String? docId;
  DateTime tglDibuat;
  String username;
  String namaLengkap;
  String email;
  String noTelp;
  String gender;
  String password;
  String foto;
  String sampul;

  User({
    required this.id,
    this.docId,
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
}
