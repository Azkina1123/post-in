part of "models.dart";

class Komentar {
  int id;
  DateTime tglDibuat;
  String konten;
  int postId;
  int userId;

  Komentar({
    required this.id,
    required this.tglDibuat,
    required this.konten,
    required this.postId,
    required this.userId,
  });
}
