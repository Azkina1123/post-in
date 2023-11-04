part of "models.dart";

class Like {
  int id;
  int? postId;
  int? komentarId;
  int userId;

  Like({
    required this.id,
    this.postId,
    this.komentarId,
    required this.userId,
  });
}
