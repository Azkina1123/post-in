part of "models.dart";

class Komentar {
  int id;
  String? docId;
  DateTime tglDibuat;
  String konten;
  int totalLike;
  int postId;
  int userId;

  Komentar({
    required this.id,
    this.docId,
    required this.tglDibuat,
    required this.konten,
    required this.totalLike,
    required this.postId,
    required this.userId,
  });
}
