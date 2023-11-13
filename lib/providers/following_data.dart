part of "providers.dart";

class FollowingData extends ChangeNotifier {
  // final List<Following> _followings = [
  //   Following(id: 1, userId2: 2, userId: 1),
  //   Following(id: 1, userId2: 3, userId: 1),
  // ];

  final CollectionReference _followings =
      FirebaseFirestore.instance.collection("followings");

  CollectionReference get followings {
    return _followings;
  }

  // int followingCount = 0;

  Future<int> get followingCount async {
    QuerySnapshot querySnapshot = await _followings.get();
    return querySnapshot.size;
  }

  void addfollowing(Following following) async {
    // int id;
    // int userId2; // diikuti
    // int userId; // yang mengikuti

    _followings.add({
      "id": "${following.userId}${following.userId2}",
      "userId2" : following.userId2,
      "userId": following.userId,
    });

    notifyListeners();
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
