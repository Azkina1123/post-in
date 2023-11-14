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
  final CollectionReference _likesRef =
      FirebaseFirestore.instance.collection("likes");

  CollectionReference get likes {
    return _likesRef;
  }

  Future<int> get likeCount async {
    QuerySnapshot querySnapshot = await _likesRef.get();
    return querySnapshot.size;
  }

  void add(Like like) async {
    int id = await likeCount + 1;
    _likesRef.doc(().toString()).set({
      "id": id,
      "postId": like.postId,
      "komentarId": like.komentarId,
      "userId": like.userId,
    });

    // notifyListeners();
  }

  void delete(String docId) {
    _likesRef.doc(docId).delete();
    // notifyListeners();
  }

  Future<Like> getLike(int userId,
      {int? postId, int? komentarId}) async {
    QuerySnapshot querySnapshot = await _likesRef.get();

    Like? like;
    querySnapshot.docs.forEach((doc) {
      if (doc.get("userId") == userId && doc.get("postId") == postId ||
          doc.get("userId") == userId && doc.get("komentarId") == komentarId) {
        like = Like(
          id: doc.get("id"),
          docId: doc.id,
          postId: doc.get("postId"),
          userId: doc.get("userId"),
          komentarId: doc.get("komentarId"),
        );
      }
    });

    return like!;
  }
}
