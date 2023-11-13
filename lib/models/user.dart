part of "models.dart";

class User {
  int id;
  DateTime tglDibuat;
  String username;
  String namaLengkap;
  String email;
  String password;
  String foto;
  

  User({
    required this.id,
    required this.tglDibuat,
    required this.username,
    required this.namaLengkap,
    required this.email,
    required this.password,
    required this.foto,
  });
}
