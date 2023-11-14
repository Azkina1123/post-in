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

  void add(User user) async {
    _usersRef.doc((await userCount + 1).toString()).set({
      "tglDibuat": user.tglDibuat,
      "username": user.username,
      "namaLengkap": user.namaLengkap,
      "email": user.email,
      "password": user.password,
      "foto": user.foto,
    });
    notifyListeners();
  }

  Future<List<User>> getUsers() async {
    QuerySnapshot querySnapshot = await _usersRef.get();
    List<User> users = [];

    querySnapshot.docs.forEach((doc) {
      users.add(
        User(
          id: doc.get("id"),
          docId: doc.id,
          tglDibuat: doc.get("tglDibuat").toDate(),
          username: doc.get("username"),
          namaLengkap: doc.get("namaLengkap"),
          email: doc.get("email"),
          password: doc.get("password"),
          foto: doc.get("foto"),
        ),
      );
    });
    return users;
  }

  Future<User> getUser(int id) async {
    QuerySnapshot querySnapshot = await _usersRef.get();

    User? user;
    querySnapshot.docs.forEach((doc) {
      if (doc.get("id") == id) {
        user = User(
          id: doc.get("id"),
          docId: doc.id,
          tglDibuat: doc.get("tglDibuat").toDate(),
          username: doc.get("username"),
          namaLengkap: doc.get("namaLengkap"),
          email: doc.get("email"),
          password: doc.get("password"),
          foto: doc.get("foto"),
        );
      }
    });

    return user!;
  }
}
