part of "models.dart";

class Like {
  int id;
  String? docId;
  int? postId;
  int? komentarId;
  String? userId;

  Like({
    required this.id,
    this.docId,
    this.postId,
    this.komentarId,
    required this.userId,
  });
}
