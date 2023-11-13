part of "models.dart";

class Komentar {
  int id;
  String? idDoc;
  DateTime tglDibuat;
  String konten;
  int totalLike;
  int postId;
  int userId;

  Komentar({
    required this.id,
    this.idDoc,
    required this.tglDibuat,
    required this.konten,
    required this.totalLike,
    required this.postId,
    required this.userId,
  });
}
