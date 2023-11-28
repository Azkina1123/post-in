part of "models.dart";

class Userdata {
  // int id;
  String? docId;
  DateTime tglDibuat;
  String username;
  String namaLengkap;
  String email;
  String noTelp;
  String gender;
  String password;
  String? foto;
  String? sampul;

  Userdata({
    // required this.id,
    this.docId,
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
}
