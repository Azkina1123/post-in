part of "models.dart";

class Post {
  int id;
  String? idDoc;
  DateTime tglDibuat;
  String konten;
  String? img;
  int totalLike;
  int totalKomentar;
  int userId;

  Post({
    required this.id,
    this.idDoc,
    required this.tglDibuat,
    required this.konten,
    this.img,
    this.totalLike = 0,
    this.totalKomentar = 0,
    required this.userId,
  });

  void like() {
    totalLike += 1;
  }

  void unlike() {
    totalLike -= 1;
  }
}
