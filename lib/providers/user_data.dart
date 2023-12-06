part of "providers.dart";

class UserData extends ChangeNotifier {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection("users");

  CollectionReference get usersCollection {
    return _usersCollection;
  }

  Future<int> get userCount async {
    QuerySnapshot querySnapshot = await _usersCollection.get();
    return querySnapshot.size;
  }

  Future<int> get lastId async {
    QuerySnapshot querySnapshot =
        await _usersCollection.orderBy("id", descending: true).get();
    if (querySnapshot.size == 0) {
      return 0;
    }
    return int.parse(querySnapshot.docs.first.get("id"));
  }

  void add(UserAcc user) async {
    _usersCollection.doc(user.id).set({
      "id": user.id,
      "tglDibuat": user.tglDibuat,
      "username": user.username,
      "namaLengkap": user.namaLengkap,
      "email": user.email,
      "gender": user.gender,
      "noTelp": user.noTelp,
      "password": user.password,
      "foto": user.foto,
      "sampul": user.sampul,
      "followings": user.followings,
      "totalFollowing": user.totalFollowing
    });
    notifyListeners();
  }

  Future<List<UserAcc>> getUsers() async {
    QuerySnapshot querySnapshot = await _usersCollection.get();
    List<UserAcc> users = [];

    for (var doc in querySnapshot.docs) {
      UserAcc user = UserAcc.fromJson(doc.data() as Map<String, dynamic>);
      users.add(user);
    }
    return users;
  }

  Future<UserAcc> getUser(String id) async {
    DocumentSnapshot userDoc = await usersCollection.doc(id).get();
    UserAcc? user = UserAcc.fromJson(userDoc.data() as Map<String, dynamic>);

    return user;
  }

  Future<List<String>> getUserFollowerIds(String id) async {
    QuerySnapshot querySnapshot =
        await _usersCollection.where("followings", arrayContains: id).get();
    List<String> userIds = [];

    for (var doc in querySnapshot.docs) {
      userIds.add(doc.get("id"));
    }
    return userIds;
  }

  void toggleIkuti(String id) async {
    String authUserId = FirebaseAuth.instance.currentUser!.uid;

    List<String> followings = (await getUser(authUserId)).followings;
    if (followings.contains(id)) {
      followings.remove(id);
    } else {
      followings.add(id);
    }

    usersCollection.doc(authUserId).update(
        {"followings": followings, "totalFollowing": followings.length});
  }

  void delete(String userId) async {
    // ambil semua user yang mengikuti akun -------------------------------
    QuerySnapshot usersDocs =
        await _usersCollection.where("followings", arrayContains: userId).get();

    // hapus semua follower akun user
    for (var userDoc in usersDocs.docs) {
      List<String> followings = List<String>.from(userDoc.get("followings"));
      followings.remove(userId);
      _usersCollection.doc(userDoc.id).update({
        "followings": followings,
        "totalFollowing": followings.length,
      });
    }

    List<String> komentarIds = [];
    // ambil semua komentar -------------
    QuerySnapshot komentarsSnapshot =
        await KomentarData()._komentarsCollection.get();
    for (var komentarDoc in komentarsSnapshot.docs) {
      Komentar komentar =
          Komentar.fromJson(komentarDoc.data() as Map<String, dynamic>);

      // hapus komentar
      if (komentarDoc.get("userId") == userId) {
        komentarIds.add(komentarDoc.id);
        KomentarData().komentarsCollection.doc(komentarDoc.id).delete();

        // hapus like yang dibuat user
      } else if (komentar.likes.contains(userId)) {
        komentar.likes.remove(userId);

        KomentarData().komentarsCollection.doc(komentar.id).update(
            {"likes": komentar.likes, "totalLike": komentar.likes.length});
      }
    }

    // ambil semua post -----------------
    QuerySnapshot postsDocs = await PostData()._postsCollection.get();
    postsDocs.docs.forEach((postDoc) async {
      Post post = await PostData().getPost(postDoc.id);

      // hapus semua post yang dibuat user
      if (postDoc.get("userId") == userId) {
        PostData().delete(postDoc.id);

        // hapus like yang dibuat user
      } else if (post.likes.contains(userId)) {
        post.likes.remove(userId);

        // komentar yang akan dihapus
        List<String> deleteKomentars = post.komentars
            // komentar yang mana id komentar nya ada di dalam list komentar milik akun
            .where((komentar) => komentarIds.contains(komentar))
            .toList();

        for (var komentar in deleteKomentars) {
          post.komentars.remove(komentar);
        }

        PostData().postsCollection.doc(post.id).update({
          "likes": post.likes,
          "totalLike": post.likes.length,
          "komentars": post.komentars,
          "totalKomentar": post.komentars.length,
        });
      }
    });

    UserAcc user = await getUser(userId);
    // hapus foto post
    if (user.foto != null) {
      FirebaseStorage.instance.refFromURL(user.foto!).delete();
    }
    if (user.sampul != null) {
      FirebaseStorage.instance.refFromURL(user.sampul!).delete();
    }

    await usersCollection.doc(FirebaseAuth.instance.currentUser!.uid).delete();
    await FirebaseAuth.instance.currentUser!.delete();

    notifyListeners();
  }

  Future<List<UserAcc>> getFollowings(String id) async {
    UserAcc authUser = await getUser(id);
    QuerySnapshot querySnapshot =
        await _usersCollection.where("id", whereIn: authUser!.followings).get();
    List<UserAcc> users = [];

    for (var doc in querySnapshot.docs) {
      UserAcc user = UserAcc.fromJson(doc.data() as Map<String, dynamic>);
      users.add(user);
    }
    return users;
  }

  Future<List<UserAcc>> getFollowers(String id) async {
    UserAcc authUser = await getUser(id);

    QuerySnapshot querySnapshot = await _usersCollection
        .where("followings", arrayContains: authUser.id)
        .get();
    List<UserAcc> users = [];

    for (var doc in querySnapshot.docs) {
      UserAcc user = UserAcc.fromJson(doc.data() as Map<String, dynamic>);
      users.add(user);
    }
    return users;
  }

  Future<int> getFollowingsCount(String userId) async {
    try {
      DocumentSnapshot userDoc = await usersCollection.doc(userId).get();
      List<dynamic> followings = userDoc['followings'];
      return followings.length;
    } catch (e) {
      print("Error getting followings count: $e");
      return 0;
    }
  }

  Future<int> getFollowersCount(String userId) async {
    try {
      QuerySnapshot followersSnapshot = await usersCollection
          .where("followings", arrayContains: userId)
          .get();
      return followersSnapshot.docs.length;
    } catch (e) {
      print("Error getting followers count: $e");
      return 0;
    }
  }

  Future<List<UserAcc>> getSearchUsers(String keyword) async {
    QuerySnapshot querySnapshot = await usersCollection
        .orderBy("tglDibuat", descending: true)
        .orderBy("id")
        .get();

    List<UserAcc> users = [];
    for (var doc in querySnapshot.docs) {
      users.add(UserAcc.fromJson(doc.data() as Map<String, dynamic>));
    }
    List<UserAcc> searchusers = users
        .where((user) =>
            user.username.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    return searchusers;
  }
}
