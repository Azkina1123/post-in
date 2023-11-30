part of "providers.dart";

class PostData extends ChangeNotifier {

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

  void toggleLike(String id) async {
QuerySnapshot querySnapshot =
        await postsCollection
            .where("id", isEqualTo: id)
            .get();

    List<String> likes = List<String>.from(querySnapshot.docs[0].get("likes"));
    String authUserId = FirebaseAuth.instance.currentUser!.uid;
    if (likes.contains(authUserId)) {
      likes.remove(authUserId);
    } else {
      likes.add(authUserId);
    }

    postsCollection
        .doc(id)
        .update({"likes": likes, "totalLike": likes.length});
  }
}
