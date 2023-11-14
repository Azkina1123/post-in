part of "providers.dart";

class FollowingData extends ChangeNotifier {
  final CollectionReference _followingsRef =
      FirebaseFirestore.instance.collection("followings");

  CollectionReference get followingsRef {
    return _followingsRef;
  }

  Future<int> get followingCount async {
    QuerySnapshot querySnapshot = await _followingsRef.get();
    return querySnapshot.size;
  }

  void add(Following following) async {
    int id = await followingCount + 1;
    _followingsRef.doc(id.toString()).set({
      "id": id,
      "userId2": following.userId2,
      "userId": following.userId,
    });
  }

  Future<List<Following>> getFollowings() async {
    QuerySnapshot querySnapshot = await _followingsRef.get();
    List<Following> followings = [];
    querySnapshot.docs.forEach((doc) {
      followings.add(Following(
        id: doc.get("id"),
        docId: doc.id,
        userId2: doc.get("userId2"),
        userId: doc.get("userId"),
      ));
    });
    return followings;
  }

}
