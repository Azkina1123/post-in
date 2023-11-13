part of "models.dart";

class User {
  int id;
  String? idDoc;
  DateTime tglDibuat;
  String username;
  String namaLengkap;
  String email;
  String password;
  String foto;

  User({
    required this.id,
    this.idDoc,
    required this.tglDibuat,
    required this.username,
    required this.namaLengkap,
    required this.email,
    required this.password,
    required this.foto,
  });
}
