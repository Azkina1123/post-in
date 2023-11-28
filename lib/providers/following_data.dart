part of "providers.dart";

// class FollowingData extends ChangeNotifier {
//   final CollectionReference _followingsRef =
//       FirebaseFirestore.instance.collection("followings");

//   CollectionReference get followingsRef {
//     return _followingsRef;
//   }

//   Future<int> get followingCount async {
//     QuerySnapshot querySnapshot = await _followingsRef.get();
//     return querySnapshot.size;
//   }

//   Future<int> get lastId async {
//     QuerySnapshot querySnapshot =
//         await _followingsRef.orderBy("id", descending: true).get();
//     return querySnapshot.docs.first.get("id");
//   }
//   void add(Following following) async {
//     int id;
//     if (followingCount == 0) {
//       id = await followingCount + 1;
//     } else {
//       id = await lastId + 1;
//     }
//     _followingsRef.doc(id.toString()).set({
//       "id": id,
//       "userId2": following.userId2,
//       "userId": following.userId,
//     });
//   }

//   Future<List<Following>> getFollowings() async {
//     QuerySnapshot querySnapshot = await _followingsRef.get();
//     List<Following> followings = [];
//     querySnapshot.docs.forEach((doc) {
//       followings.add(Following(
//         id: doc.get("id"),
//         docId: doc.id,
//         userId2: doc.get("userId2"),
//         userId: doc.get("userId"),
//       ));
//     });
//     return followings;
//   }

//   Future<int> getFollowingCount(int userId) async {
//     QuerySnapshot querySnapshot = await _followingsRef.where("userId", isEqualTo: userId).get();
//     return querySnapshot.size;
//   }

//   Future<int> getFollowerCount(int userId2) async {
//     QuerySnapshot querySnapshot =
//         await _followingsRef.where("userId2", isEqualTo: userId2).get();
//     return querySnapshot.size;
//   }
// }
