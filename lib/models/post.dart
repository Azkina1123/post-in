part of "models.dart";

class Post {
  int id;
  DateTime tglDibuat;
  String konten;
  ImageProvider<Object>? img;
  int userId;

  Post({
    required this.id,
    required this.tglDibuat,
    required this.konten,
    this.img,
    required this.userId,
  });
}
