part of "models.dart";

class Komentar {
  String id;
  DateTime tglDibuat;
  String konten;
  String postId;
  String userId;

  int totalLike = 0;
  List<String> likes = [];

  Komentar({
    required this.id,
    required this.tglDibuat,
    required this.konten,
    required this.postId,
    required this.userId,
  });

  factory Komentar.fromJson(Map<String, dynamic> json) {
    Komentar komentar = Komentar(
      id: json["id"],
      tglDibuat: json["tglDibuat"].toDate(),
      konten: json["konten"],
      postId: json["postId"],
      userId: json["userId"],
    );

    komentar.likes = List<String>.from(json["likes"]);
    komentar.totalLike = komentar.likes.length;
    return komentar;
  }

}
