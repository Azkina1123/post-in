part of "models.dart";

class Post {
  int id;
  DateTime createdAt;
  String content;
  ImageProvider<Object>? img;
  int userId;

  Post({
    required this.id,
    required this.createdAt,
    required this.content,
    this.img,
    required this.userId,
  });
}
