part of "providers.dart";

// class LikeData extends ChangeNotifier {
//   final CollectionReference _likesRef =
//       FirebaseFirestore.instance.collection("likes");

//   CollectionReference get likesRef {
//     return _likesRef;
//   }

//   Future<int> get likeCount async {
//     QuerySnapshot querySnapshot = await _likesRef.get();
//     return querySnapshot.size;
//   }

//   Future<int> get lastId async {
//     QuerySnapshot querySnapshot =
//         await _likesRef.orderBy("id", descending: true).get();
//     if (querySnapshot.size == 0) {
//       return 0;
//     }
//     return querySnapshot.docs.first.get("id");
//   }

//   void add(Like like) async {
//     int id;
//     if (likeCount == 0) {
//       id = await likeCount + 1;
//     } else {
//       id = await lastId + 1;
//     }
//     _likesRef.doc(id.toString()).set({
//       "id": id,
//       "postId": like.postId,
//       "komentarId": like.komentarId,
//       "userId": like.userId,
//     });
//   }

//   void delete(String docId) {
//     _likesRef.doc(docId).delete();
//   }

//   Future<Like> getLike(int userId, {int? postId, int? komentarId}) async {
//     QuerySnapshot querySnapshot = await _likesRef.get();

//     Like? like;

//     querySnapshot.docs.forEach((doc) {
//       if (doc.get("userId") == userId &&
//               doc.get("postId") == postId &&
//               komentarId == null ||
//           doc.get("userId") == userId &&
//               doc.get("komentarId") == komentarId &&
//               postId == null) {
//         like = Like(
//           id: doc.get("id"),
//           docId: doc.id,
//           postId: doc.get("postId"),
//           userId: doc.get("userId"),
//           komentarId: doc.get("komentarId"),
//         );
//       }
//     });

//     return like!;
//   }
// }
