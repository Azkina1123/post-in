part of "models.dart";

class Like {
  int id;
  String type; // 1 -> post, 2 ->
  int? postId;
  int? komentarId;
  int userId;

  Like({
    required this.id,
    required this.type,
    this.postId,
    this.komentarId,
    required this.userId,
  });
}
