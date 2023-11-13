part of "providers.dart";

class LikeData extends ChangeNotifier {
  // final List<Like> _likes = [
  //   Like(id: 1, userId: 2, postId: 4),
  //   Like(id: 2, userId: 4, postId: 5),
  //   Like(id: 3, userId: 1, postId: 5),
  //   Like(id: 4, userId: 2, postId: 4),
  //   Like(id: 5, userId: 3, postId: 4),
  //   Like(id: 6, userId: 1, postId: 4),
  //   Like(id: 7, userId: 4, postId: 5),
  //   Like(id: 8, userId: 5, postId: 4),
  // ];
  final CollectionReference _likes =
      FirebaseFirestore.instance.collection("likes");

  CollectionReference get likes {
    return _likes;
  }

  // int likeCount = 0;

  Future<int> get likeCount async {
    QuerySnapshot querySnapshot = await _likes.get();
    return querySnapshot.size;
  }

  void addlike(Like like) async {
    _likes.add({
      "id": await likeCount + 1,
      "postId": like.postId,
      "komentarId": like.komentarId,
      "userId": like.userId,
    });

    // notifyListeners();
  }

  void deleteLike(String id) {
    _likes.doc(id).delete();
    // notifyListeners();
  }

  // int getLikesNumber({int? postId, int? komentarId}) {
  //   return _likes
  //       .where(((like) {
  //         if (komentarId == null) {
  //           return like.postId == postId;
  //         } else if (postId == null) {
  //           return like.userId == komentarId;
  //         }
  //         return false;
  //       }))
  //       .toList()
  //       .length;
  // }

  Future<bool> isLiked(int userId, {int? postId, int? komentarId}) async {
    if (postId != null) {
      return _likes
              .where("userId", isEqualTo: userId)
              .where("postId", isEqualTo: postId)
              .snapshots().length != 0;
    } else if (komentarId != null) {
      return _likes
              .where("userId", isEqualTo: userId)
              .where("komentarId", isEqualTo: komentarId)
              .snapshots().length != 0;
    }
    return false;

    // return _likes
    //     .where(
    //       ((like) {
    // if (komentarId == null) {
    //   return like.userId == userId && like.postId == postId;
    // } else if (postId == null) {
    //   return like.userId == userId && like.komentarId == komentarId;
    // }
    // return true;
    //       }),
    //     )
    //     .toList()
    //     .isNotEmpty;
  }

  // int totalLikes(int postId) {
  //   return _likes
  //       .where(
  //         ((like) => like.postId == postId),
  //       )
  //       .toList()
  //       .length;
  // }
}
