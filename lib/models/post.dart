part of "models.dart";

class Post {
  String id;
  DateTime tglDibuat;
  String konten;
  String? img;
  String userId;

  int totalLike = 0;
  List<String> likes = [];

  int totalKomentar = 0;
  List<String> komentars = [];

  Post({
    required this.id,
    required this.tglDibuat,
    required this.konten,
    this.img,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    Post post = Post(
      id: json["id"],
      tglDibuat: json["tglDibuat"].toDate(),
      img: json["img"],
      konten: json["konten"],
      userId: json["userId"],
    );

    post.likes = List<String>.from(json["likes"]);
    post.totalLike = post.likes.length;
    post.komentars = List<String>.from(json["komentars"]);
    post.totalKomentar = post.komentars.length;

    return post;
  }

}
