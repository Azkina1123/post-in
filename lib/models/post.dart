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

  void toggleLike(BuildContext context) async {
    QuerySnapshot querySnapshot =
        await Provider.of<PostData>(context, listen: false)
            .postsCollection
            .where("id", isEqualTo: id)
            .get();

    List<String> likes = List<String>.from(querySnapshot.docs[0].get("likes"));
    String authUserId = FirebaseAuth.instance.currentUser!.uid;
    if (likes.contains(authUserId)) {
      likes.remove(authUserId);
    } else {
      likes.add(authUserId);
    }

    Provider.of<PostData>(context, listen: false)
        .postsCollection
        .doc(id)
        .update({"likes": likes, "totalLike": likes.length});
  }

  Future<bool> isLiked(BuildContext context) async {
    QuerySnapshot querySnapshot =
        await Provider.of<PostData>(context, listen: false)
            .postsCollection
            .where("id", isEqualTo: id)
            .get();

    List<String> likes = List<String>.from(querySnapshot.docs[0].get("likes"));

    return likes.contains(FirebaseAuth.instance.currentUser!.uid);
  }
}
