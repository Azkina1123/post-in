part of "models.dart";

class Post {
  String id;
  DateTime tglDibuat;
  String konten;
  String? img;
  String userId;

  List<String> likes = [];
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
    post.komentars = List<String>.from(json["komentars"]);

    return post;
  }

  void toggleLike(BuildContext context) async {
    QuerySnapshot querySnapshot =
        await Provider.of<PostData>(context, listen: false)
            .postsCollection
            .where("id", isEqualTo: id)
            .get();
    // Post post = Post.fromJson(querySnapshot.docs[0] as Map<String, dynamic>);
    // final post =
    List<String> likes = List<String>.from(querySnapshot.docs[0].get("likes"));
    // .map((userId) => userId.toString());
    String authUserId =
        Provider.of<AuthData>(context, listen: false).authUser.id;
    if (likes.contains(authUserId)) {
      likes.remove(authUserId);
    } else {
      likes.add(authUserId);
    }

    Provider.of<PostData>(context, listen: false)
        .postsCollection
        .doc(id)
        .update({"likes": likes});
  }

  Future<bool> isLiked(BuildContext context) async {
    QuerySnapshot querySnapshot =
        await Provider.of<PostData>(context, listen: false)
            .postsCollection
            .where("id", isEqualTo: id)
            .get();

    List<String> likes = List<String>.from(querySnapshot.docs[0].get("likes"));

    return likes
        .contains(Provider.of<AuthData>(context, listen: false).authUser.id);
  }
}
