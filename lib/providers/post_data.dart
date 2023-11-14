part of "providers.dart";

class PostData extends ChangeNotifier {
  // final List<Post> _postsRef = [
  //   Post(
  //     id: 1,
  //     tglDibuat: DateTime.utc(2023, 5, 22, 7, 00),
  //     konten:
  //         "Selamat ulang tahun yang ke-25, [nama teman]! Semoga hari ini penuh kebahagiaan dan keberuntungan. Semoga semua impianmu terwujud. 🎂🎉, #UlangTahun #TemanTerbaik",
  //     userId: 3,
  //     totalKomentar: 2,
  //     totalLike: 0,
  //   ),
  //   Post(
  //     id: 2,
  //     tglDibuat: DateTime.utc(2023, 5, 30, 23, 12),
  //     konten:
  //         "Hari pertama liburan di [nama destinasi]! Pemandangan luar biasa dan cuaca cerah. Bersama [nama teman/keluarga] siap menjelajahi petualangan ini. 🏝️☀️ #LiburanSeru #Petualangan",
  //     userId: 1,
  //     img: NetworkImage("https://picsum.photos/800/500"),
  //     totalKomentar: 2,
  //     totalLike: 0,
  //   ),
  //   Post(
  //     id: 3,
  //     tglDibuat: DateTime.utc(2023, 8, 2, 17, 54),
  //     konten:
  //         "Cuaca cerah hari ini, matahari bersinar terang! Semoga hari ini penuh semangat. ☀️ #CuacaBagus #Semangat",
  //     userId: 2,
  //     totalKomentar: 1,
  //     totalLike: 0,
  //   ),
  //   Post(
  //     id: 4,
  //     tglDibuat: DateTime.utc(2023, 10, 11, 11, 22),
  //     konten:
  //         "Senang mengumumkan bahwa saya berhasil menyelesaikan proyek [nama proyek] hari ini! Terima kasih kepada semua yang telah mendukung saya. 💪🎉 #Pencapaian #ProyekSelesai",
  //     userId: 5,
  //     img: NetworkImage("https://picsum.photos/800/400"),
  //     totalKomentar: 0,
  //     totalLike: 5,
  //   ),
  //   Post(
  //     id: 5,
  //     tglDibuat: DateTime.utc(2023, 11, 1, 4, 29),
  //     konten:
  //         "Keindahan alam yang menenangkan. Saya merasa beruntung bisa melihat pemandangan seperti ini. 🏞️❤️ #PemandanganAlam #Kedamaian",
  //     userId: 4,
  //     totalKomentar: 0,
  //     totalLike: 3,
  //   ),
  // ];

  final CollectionReference _postsRef =
      FirebaseFirestore.instance.collection("posts");

  CollectionReference get postsRef {
    return _postsRef;
  }

  Future<int> get postCount async {
    QuerySnapshot querySnapshot = await _postsRef.get();
    return querySnapshot.size;
  }
  Future<int> get lastId async {
    QuerySnapshot querySnapshot =
        await _postsRef.orderBy("id", descending: true).get();
    return querySnapshot.docs.first.get("id");
  }
  // tambahkan post baru
  void add(Post post) async {
    int max = 99999999;
    int min = 10000000;
    int randomNumber = Random().nextInt(max - min + 1) + min;

    String? url;
    if (post.img != null) {
      Reference ref =
          FirebaseStorage.instance.ref().child("posts/${randomNumber}.jpg");
      await ref.putFile(File(post.img!));
      url = await ref.getDownloadURL();
    }

    int id;
    if (postCount == 0) {
      id = await postCount + 1;
    } else {
      id = await lastId + 1;
    }
    _postsRef.doc(id.toString()).set({
      "id": id,
      "tglDibuat": post.tglDibuat,
      "konten": post.konten,
      "img": url,
      "totalLike": post.totalLike,
      "totalKomentar": post.totalKomentar,
      "userId": post.userId,
    });
    // notifyListeners();
  }

  void delete(String docId) {
    _postsRef.doc(docId).delete();
  }

  void updateTotalLike(String docId, int totalLike) {
    _postsRef.doc(docId).update({
      "totalLike": totalLike,
    });
    // notifyListeners();
  }

  void updateTotalKomentar(String docId, int totalKomentar) {
    _postsRef.doc(docId).update({
      "totalKomentar": totalKomentar,
    });
    // notifyListeners();
  }

  Future<List<Post>> getPosts() async {
    QuerySnapshot querySnapshot = await _postsRef.get();
    List<Post> posts = [];
    querySnapshot.docs.forEach((doc) {
      posts.add(
        Post(
          id: doc.get("id"),
          tglDibuat: doc.get("tglDibuat").toDate(),
          konten: doc.get("konten"),
          userId: doc.get("userId"),
        ),
      );
    });
    return posts;
  }

  Future<Post> getPost(int id) async {
    QuerySnapshot querySnapshot = await _postsRef.get();

    Post? post;
    querySnapshot.docs.forEach((doc) {
      if (doc.get("id") == id) {
        post = Post(
          id: doc.get("id"),
          docId: doc.id,
          tglDibuat: doc.get("tglDibuat").toDate(),
          konten: doc.get("konten"),
          userId: doc.get("userId"),
        );
      }
    });

    return post!;
  }
}
