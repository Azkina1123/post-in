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

    querySnapshot.docs.forEach((doc) {
      UserAcc user = UserAcc.fromJson(doc.data() as Map<String, dynamic>);
      users.add(user);
    });
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

    querySnapshot.docs.forEach((doc) {
      userIds.add(doc.get("id"));
    });
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
    // hapus semua following dari user lain yg mengikuti akun ini
    QuerySnapshot usersDocs =
        await _usersCollection.where("followings", arrayContains: userId).get();

    // hapus semua follow user dari collection users
    usersDocs.docs.forEach((user) {
      List<String> followings = List<String>.from(user.get("followings"));
      followings.remove(userId);
      _usersCollection.doc(user.id).update({
        "followings": followings,
        "totalFollowing": followings.length,
      });
    });

    // hapus semua post user dari collection posts -----------------------
    QuerySnapshot postsDocs = await PostData()
        ._postsCollection
        .where("userId", isEqualTo: userId)
        .get();

    // hapus semua post user dari collection users
    postsDocs.docs.forEach((post) {
      PostData().delete(post.id);
    });

    // hapus semua komentar user dari collection komentars -----------------------
    QuerySnapshot komentarsDocs = await KomentarData()
        ._komentarsCollection
        .where("userId", isEqualTo: userId)
        .get();
    List<String> komentarIds = [];
    komentarsDocs.docs.forEach((komentar) async {
      // simpan id komentar user
      komentarIds.add(komentar.id);
      // hapus semua komentar dari collection komentars
      KomentarData()._komentarsCollection.doc(komentar.id).delete();
    });

    // perbarui komentar di semua post -----------------
    postsDocs = await PostData()._postsCollection.get();
    postsDocs.docs.forEach((post) {
      List<String> komentars = [];
      komentars = List<String>.from(post.get("komentars"));

      komentars.forEach(
        (id) {
          if (komentarIds.contains(id)) {
            komentars.remove(id);
          }
        },
      );
      PostData()
          .postsCollection
          .doc(post.id)
          .update({"komentars": komentars, "totalKomentar": komentars.length});
    });

    // perbarui semua like komentar ----------------------------------
    komentarsDocs = await KomentarData()._komentarsCollection.get();
    komentarsDocs.docs.forEach((komentar) {
      List<String> likes = [];
      likes = List<String>.from(komentar.get("likes"));

      likes.removeWhere(
        (userIdLike) => userIdLike == userId,
      );
      KomentarData()
          .komentarsCollection
          .doc(userId)
          .update({"likes": likes, "totalLike": likes.length});
    });

    // taruh fungsi hapus user dari users collection di sini
    await usersCollection.doc(FirebaseAuth.instance.currentUser!.uid).delete();
    await FirebaseAuth.instance.currentUser!.delete();

    notifyListeners();
  }

  Future<List<UserAcc>> getFollowings(String id) async {
    UserAcc authUser = await getUser(id);
    QuerySnapshot querySnapshot =
        await _usersCollection.where("id", whereIn: authUser!.followings).get();
    List<UserAcc> users = [];

    querySnapshot.docs.forEach((doc) {
      UserAcc user = UserAcc.fromJson(doc.data() as Map<String, dynamic>);
      users.add(user);
    });
    return users;
  }

  Future<List<UserAcc>> getFollowers(String id) async {
    UserAcc authUser = await getUser(id);

    QuerySnapshot querySnapshot = await _usersCollection
        .where("followings", arrayContains: authUser.id)
        .get();
    List<UserAcc> users = [];

    querySnapshot.docs.forEach((doc) {
      UserAcc user = UserAcc.fromJson(doc.data() as Map<String, dynamic>);
      users.add(user);
    });
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
    querySnapshot.docs.forEach((doc) {
      users.add(UserAcc.fromJson(doc.data() as Map<String, dynamic>));
    });
    List<UserAcc> searchusers = users
        .where((user) =>
            user.username.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    return searchusers;
  }
}
