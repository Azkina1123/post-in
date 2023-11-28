part of "providers.dart";

class UserData extends ChangeNotifier {
  // final List<User> _users = [
  //   User(
  //     id: 1,
  //     tglDibuat: DateTime.now(),
  //     username: "alu",
  //     namaLengkap: "Muhammad Alucard",
  //     email: "alu.ml@gmail.com",
  //     password: "alufeed",
  //     foto: NetworkImage(
  //         "https://www.ligagame.tv/images/Nana-Hero-Mobile-Legends_4f22c.jpg"),
  //   ),
  //   User(
  //     id: 2,
  //     tglDibuat: DateTime.now(),
  //     username: "azkina1123",
  //     namaLengkap: "Aziizah Oki",
  //     email: "azzz@gmail.com",
  //     password: "hehe",
  //     foto: const NetworkImage(
  //       "https://avatars.githubusercontent.com/Azkina1123",
  //     ),
  //   ),
  //   User(
  //     id: 3,
  //     tglDibuat: DateTime.now(),
  //     username: "Aliyairfani",
  //     namaLengkap: "Aliya Irfani",
  //     email: "aliyaff@gmail.com",
  //     password: "nice",
  //     foto: const NetworkImage(
  //       "https://avatars.githubusercontent.com/Aliyairfani",
  //     ),
  //   ),
  //   User(
  //     id: 4,
  //     tglDibuat: DateTime.now(),
  //     username: "Chintialiuw",
  //     namaLengkap: "Chintia Liu",
  //     email: "chinnnt@gmail.com",
  //     password: "good",
  //     foto: const NetworkImage(
  //       "https://avatars.githubusercontent.com/Chintialiuw",
  //     ),
  //   ),
  //   User(
  //     id: 5,
  //     tglDibuat: DateTime.now(),
  //     username: "Venomz22",
  //     namaLengkap: "Dimas Arya",
  //     email: "dann@gmail.com",
  //     password: "awesome",
  //     foto: const NetworkImage(
  //       "https://avatars.githubusercontent.com/Venomz22",
  //     ),
  //   ),

  // ];
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("users");

  CollectionReference get usersRef {
    return _usersRef;
  }

  Future<int> get userCount async {
    QuerySnapshot querySnapshot = await _usersRef.get();
    return querySnapshot.size;
  }

  Future<int> get lastId async {
    QuerySnapshot querySnapshot =
        await _usersRef.orderBy("id", descending: true).get();
    if (querySnapshot.size == 0) {
      return 0;
    }
    return querySnapshot.docs.first.get("id");
  }

  void add(Userdata user) async {
    // int id;
    // if (userCount == 0) {
    //   id = await userCount + 1;
    // } else {
    //   id = await lastId + 1;
    // }

    // final id =
    _usersRef.doc(user.docId).set({
      "id": user.docId,
      "tglDibuat": user.tglDibuat,
      "username": user.username,
      "namaLengkap": user.namaLengkap,
      "email": user.email,
      "gender": user.gender,
      "noTelp": user.noTelp,
      "password": user.password,
      // "foto": user.foto,
      // "sampul": user.sampul,
    });
    notifyListeners();
  }

  Future<List<Userdata>> getUsers() async {
    QuerySnapshot querySnapshot = await _usersRef.get();
    List<Userdata> users = [];

    querySnapshot.docs.forEach((doc) {
      users.add(
        Userdata(
          // id: doc.get("id"),
          docId: doc.get("id"),
          tglDibuat: doc.get("tglDibuat").toDate(),
          username: doc.get("username"),
          namaLengkap: doc.get("namaLengkap"),
          email: doc.get("email"),
          gender: doc.get("gender"),
          noTelp: doc.get("noTelp"),
          // sampul: doc.get("sampul"),
          password: doc.get("password"),
          // foto: doc.get("foto"),
        ),
      );
    });
    return users;
  }

  Future<Userdata> getUser(String? id) async {
    QuerySnapshot querySnapshot = await _usersRef.get();

    Userdata? user;
    querySnapshot.docs.forEach((doc) {
      if (doc.get("id") == id) {
        user = Userdata(
          // id: doc.get("id"),
          docId: doc.id,
          tglDibuat: doc.get("tglDibuat").toDate(),
          username: doc.get("username"),
          namaLengkap: doc.get("namaLengkap"),
          email: doc.get("email"),
          gender: doc.get("gender"),
          noTelp: doc.get("noTelp"),
          // sampul: doc.get("sampul"),
          password: doc.get("password"),
          // foto: doc.get("foto"),
        );
      }
    });
    return user!;
  }
}
