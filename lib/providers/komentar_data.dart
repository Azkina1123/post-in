part of "providers.dart";

class KomentarData extends ChangeNotifier {
  final CollectionReference _komentarsRef =
      FirebaseFirestore.instance.collection("komentars");

  // final List<Komentar> _komentars = [
  //   Komentar(
  //     id: 1,
  //     tglDibuat: DateTime.utc(2023, 11, 1, 2, 55),
  //     konten:
  //         "Selamat ulang tahun, sahabat! Semoga semua hari-harimu penuh dengan cinta dan kebahagiaan. 🎂❤️",
  //     postId: 1,
  //     userId: 1,
  //   ),
  //   Komentar(
  //     id: 2,
  //     tglDibuat: DateTime.utc(2023, 11, 2),
  //     konten:
  //         "Selamat ulang tahun! Semoga usiamu semakin berharga dan penuh dengan momen-momen indah. 🎂✨",
  //     postId: 2,
  //     userId: 1,
  //   ),
  //   Komentar(
  //     id: 3,
  //     tglDibuat: DateTime.utc(2023, 11, 2),
  //     konten:
  //         "Selamat ulang tahun, teman! Semoga hidupmu dihiasi dengan senyuman dan cinta. 🎁🌟",
  //     postId: 1,
  //     userId: 1,
  //   ),
  //   Komentar(
  //     id: 4,
  //     tglDibuat: DateTime.utc(2023, 11, 3),
  //     konten: "Siapa itu gak ada kenal aku 😒😒🤔",
  //     postId: 2,
  //     userId: 1,
  //   ),
  //   Komentar(
  //     id: 5,
  //     tglDibuat: DateTime.utc(2023, 11, 4, 07, 11),
  //     konten: "💕💕💕💕💕",
  //     postId: 3,
  //     userId: 1,
  //   ),
  // ];

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

  void delete(String docId) {
    _komentarsRef.doc(docId).delete();
  }

  void updateTotalLike(String docId, int totalLike) {
    _komentarsRef.doc(docId).update({
      "totalLike": totalLike,
    });
    // notifyListeners();
  }

  Future<List<Komentar>> getKomentars({int? postId, int? userId}) async {
    QuerySnapshot? querySnapshot = await _komentarsRef.where("postId", isEqualTo: postId).get();
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
      if (doc.get("id") == "id") {
        Komentar(
          id: doc.get("id"),
          docId: doc.id,
          tglDibuat: doc.get("tglDibuat"),
          konten: doc.get("konten"),
          totalLike: doc.get("totalLike"),
          postId: doc.get("postId"),
          userId: doc.get("userId"),
        );
      }
    });

    return komentar!;
  }
}
