part of "providers.dart";

class FollowingData extends ChangeNotifier {

  final CollectionReference _followingsRef =
      FirebaseFirestore.instance.collection("followings");

  CollectionReference get followingsRef {
    return _followingsRef;
  }

  // int followingCount = 0;

  Future<int> get followingCount async {
    QuerySnapshot querySnapshot = await _followingsRef.get();
    return querySnapshot.size;
  }

  void addfollowing(Following following) async {

    _followingsRef.add({
      "id": await followingCount + 1,
      "userId2" : following.userId2,
      "userId": following.userId,
    });

  }

    Future<List<Following>> getFollowings() async {
    QuerySnapshot querySnapshot = await _followingsRef.get();
    var documents = querySnapshot.docs;
    List<Following> followings = [];
    for (int i = 0; i < documents.length; i++) {
      followings.add(
        Following(
          id: documents[i].get("id"), 
          idDoc: documents[i].id,
          userId2: documents[i].get("userId2"), 
          userId: documents[i].get("userId"),
        )
      );
    }
    return followings;
  }

  // void deletefollowing(Following following) {
  //   _followings.remove(following);
  //   notifyListeners();
  // }

  // List<Following> getFollowed(int userId) {
  //   return _followings
  //       .where((following) => following.userId2 == userId)
  //       .toList();
  // }

  // int getfollowingsNumber({int? postId, int? komentarId}) {
  //   return _followings
  //       .where(((following) {
  //         if (komentarId == null) {
  //           return following.postId == postId;
  //         } else if (postId == null) {
  //           return following.userId == komentarId;
  //         }
  //         return false;
  //       }))
  //       .toList()
  //       .length;
  // }

  // bool isfollowed(int userId, {int? postId, int? komentarId}) {
  //   return _followings
  //       .where(
  //         ((following) {
  //           if (komentarId == null) {
  //             return following.userId == userId && following.postId == postId;
  //           } else if (postId == null) {
  //             return following.userId == userId && following.komentarId == komentarId;
  //           }
  //           return true;
  //         }),
  //       )
  //       .toList()
  //       .isNotEmpty;
  // }

  // int totalfollowings(int postId) {
  //   return _followings
  //       .where(
  //         ((following) => following.postId == postId),
  //       )
  //       .toList()
  //       .length;
  // }
}
