part of "models.dart";

class Komentar {
  String id;
  DateTime tglDibuat;
  String konten;
  int totalLike;
  int postId;
  int userId;

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
    return komentar;
  }

  void toggleLike(BuildContext context) async {
    QuerySnapshot querySnapshot =
        await Provider.of<KomentarData>(context, listen: false)
            .komentarsCollection
            .where("id", isEqualTo: id)
            .get();

    List<String> likes = List<String>.from(querySnapshot.docs[0].get("likes"));

    String authUserId =
        Provider.of<AuthData>(context, listen: false).authUser.id;
    if (likes.contains(authUserId)) {
      likes.remove(authUserId);
    } else {
      likes.add(authUserId);
    }

    Provider.of<KomentarData>(context, listen: false)
        .komentarsCollection
        .doc(id)
        .update({"likes": likes});
  }

  Future<bool> isLiked(BuildContext context) async {
    QuerySnapshot querySnapshot =
        await Provider.of<KomentarData>(context, listen: false)
            .komentarsCollection
            .where("id", isEqualTo: id)
            .get();

    List<String> likes = List<String>.from(querySnapshot.docs[0].get("likes"));

    return likes
        .contains(Provider.of<AuthData>(context, listen: false).authUser.id);
  }
}
