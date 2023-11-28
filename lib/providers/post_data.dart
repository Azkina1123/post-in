part of "providers.dart";

class PostData extends ChangeNotifier {
  // final List<Post> _postsCollection = [
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

  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection("posts");

  CollectionReference get postsCollection {
    return _postsCollection;
  }

  Future<int> get postCount async {
    QuerySnapshot querySnapshot = await _postsCollection.get();
    return querySnapshot.size;
  }

  Future<int> get lastId async {
    QuerySnapshot querySnapshot =
        await _postsCollection.orderBy("tglDibuat", descending: true).get();
    if (querySnapshot.size == 0) {
      return 0;
    }
    return int.parse(querySnapshot.docs.first.get("id"));
  }

  // tambahkan post baru
  void add(Post post) async {
    int max = 99999999;
    int min = 10000000;
    int randomNumber = Random().nextInt(max - min + 1) + min;

    String? url;
    if (post.img != null) {
      Reference ref =
          FirebaseStorage.instance.ref().child("posts/$randomNumber.jpg");
      await ref.putFile(File(post.img!));
      url = await ref.getDownloadURL();
    }

    int id;
    if (postCount == 0) {
      id = await postCount + 1;
    } else {
      id = await lastId + 1;
    }

    _postsCollection.doc(id.toString()).set({
      "id": id.toString(),
      "tglDibuat": post.tglDibuat,
      "konten": post.konten,
      "img": url,
      "userId": post.userId,
      "likes": post.likes,
      "komentars": post.komentars,
      "totalLike": post.totalLike,
      "totalKomentar": post.totalKomentar,
    });
    // notifyListeners();
  }

  void delete(String id) async {
    // Post post = await getPost(id);

    // hapus post
    _postsCollection.doc(id).delete();

    CollectionReference komentarsRef =
        FirebaseFirestore.instance.collection("komentars");
    QuerySnapshot komentars =
        await komentarsRef.where("postId", isEqualTo: id).get();

    // hapus semua komentar yang mengomentari post
    komentars.docs.forEach((komentar) {
      komentarsRef.doc(komentar.id).delete();
    });
  }

  Future<List<Post>> getPosts() async {
    QuerySnapshot querySnapshot = await _postsCollection.get();
    List<Post> posts = [];
    querySnapshot.docs.forEach((doc) {
      Post post = Post.fromJson(doc.data() as Map<String, dynamic>);
      posts.add(post);
    });
    return posts;
  }

  Future<Post> getPost(String id) async {
    QuerySnapshot querySnapshot =
        await _postsCollection.where("id", isEqualTo: id).get();

    final posts = querySnapshot.docs;

    Post? post = Post.fromJson(posts[0].data() as Map<String, dynamic>);
    return post;
  }
}
