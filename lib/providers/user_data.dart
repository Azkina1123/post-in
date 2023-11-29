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
      "followings": user.followings
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
    QuerySnapshot querySnapshot =
        await _usersCollection.where("id", isEqualTo: id).get();

    final users = querySnapshot.docs;
    // print(users.length);
    UserAcc? user = UserAcc.fromJson(users[0].data() as Map<String, dynamic>);

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

  
}
