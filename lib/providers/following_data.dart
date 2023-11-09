part of "providers.dart";

class FollowingData extends ChangeNotifier {
  final List<Following> _followings = [
    Following(id: 1, userId1: 2, userId2: 1),
    Following(id: 1, userId1: 3, userId2: 1),
  ];

  UnmodifiableListView get followings {
    return UnmodifiableListView(_followings);
  }

  int get followingsCount {
    return _followings.length;
  }

  void addfollowing(Following following) {
    _followings.add(following);
    notifyListeners();
  }

  void deletefollowing(Following following) {
    _followings.remove(following);
    notifyListeners();
  }

  List<Following> getFollowed(int userId) {
    return _followings
        .where((following) => following.userId2 == userId)
        .toList();
  }

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
