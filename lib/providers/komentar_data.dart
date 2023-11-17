part of "providers.dart";

class KomentarData extends ChangeNotifier {
  final CollectionReference _komentarsRef =
      FirebaseFirestore.instance.collection("komentars");

  CollectionReference get komentarsRef {
    return _komentarsRef;
  }

  Future<int> get komentarCount async {
    QuerySnapshot querySnapshot = await _komentarsRef.get();
    return querySnapshot.size;
  }

  Future<int> get lastId async {
    QuerySnapshot querySnapshot =
        await _komentarsRef.orderBy("id", descending: true).get();
        if (querySnapshot.size == 0) {
      return 0;
    }
    return querySnapshot.docs.first.get("id");
  }

  void add(Komentar komentar) async {
    int id;
    if (komentarCount == 0) {
      id = await komentarCount + 1;
    } else {
      id = await lastId + 1;
    }

    _komentarsRef.doc(id.toString()).set({
      "id": id,
      "tglDibuat": komentar.tglDibuat,
      "konten": komentar.konten,
      "totalLike": komentar.totalLike,
      "postId": komentar.postId,
      "userId": komentar.userId
    });
    // notifyListeners();
  }

  void delete(int id) async {
    Komentar komentar = await getkomentar(id);

    // hapus komentar
    _komentarsRef.doc(komentar.docId).delete();

    CollectionReference likesRef =
        FirebaseFirestore.instance.collection("likes");
    QuerySnapshot likes =
        await likesRef.where("komentarId", isEqualTo: id).get();

    // hapus semua like yang menyukai komentar
    likes.docs.forEach((like) {
      likesRef.doc(like.id).delete();
    });
  }

  void updateTotalLike(String docId, int totalLike) {
    _komentarsRef.doc(docId).update({
      "totalLike": totalLike,
    });
    // notifyListeners();
  }

  Future<List<Komentar>> getKomentars({int? postId, int? userId}) async {
    QuerySnapshot? querySnapshot =
        await _komentarsRef.where("postId", isEqualTo: postId).get();
    if (postId != null) {
      querySnapshot = await _komentarsRef
          .where("postId", isEqualTo: postId)
          .orderBy("totalLike", descending: true)
          .orderBy("tglDibuat", descending: true)
          .get();
    } else if (userId != null) {
      querySnapshot = await _komentarsRef
          .where("userId", isEqualTo: userId)
          .orderBy("totalLike", descending: true)
          .orderBy("tglDibuat", descending: true)
          .get();
    }

    List<Komentar> komentars = [];
    querySnapshot!.docs.forEach((doc) {
      komentars.add(
        Komentar(
          id: doc.get("id"),
          docId: doc.id,
          tglDibuat: doc.get("tglDibuat").toDate(),
          konten: doc.get("konten"),
          totalLike: doc.get("totalLike"),
          postId: doc.get("postId"),
          userId: doc.get("userId"),
        ),
      );
    });

    return komentars;
  }

  Future<Komentar> getkomentar(int id) async {
    QuerySnapshot querySnapshot = await _komentarsRef.get();

    Komentar? komentar;
    querySnapshot.docs.forEach((doc) {
      if (doc.get("id") == id) {
        komentar = Komentar(
          id: doc.get("id"),
          docId: doc.id,
          tglDibuat: doc.get("tglDibuat").toDate(),
          konten: doc.get("konten"),
          totalLike: doc.get("totalLike"),
          postId: doc.get("postId"),
          userId: doc.get("userId"),
        );
      }
    });

    return komentar!;
  }

  Future<int> getKomentarCount(int postId) async {
    QuerySnapshot? querySnapshot =
        await _komentarsRef.where("postId", isEqualTo: postId).get();
    return querySnapshot.docs.length;
  }
}
