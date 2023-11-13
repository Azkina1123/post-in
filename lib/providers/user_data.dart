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

  // final List<User> _users = [];
  // User? user;

  // UnmodifiableListView get users {
  //   return UnmodifiableListView(_users);
  // }

  Future<List<User>> getUsers() async {
    QuerySnapshot querySnapshot = await _usersRef.get();
    var documents = querySnapshot.docs;
    List<User> users = [];
    for (int i = 0; i < documents.length; i++) {
      users.add(User(
        id: documents[i].get("id"),
        idDoc: documents[i].id,
        tglDibuat: documents[i].get("tglDibuat").toDate(),
        username: documents[i].get("username"),
        namaLengkap: documents[i].get("namaLengkap"),
        email: documents[i].get("email"),
        password: documents[i].get("password"),
        foto: documents[i].get("foto"),
      ));
    }
    return users;
  }

  Future<User> getUser({int? id, String? idDoc}) async {
    QuerySnapshot querySnapshot = await _usersRef.get();
    var documents = querySnapshot.docs;
    int i = documents
        .indexWhere((user) => user.id == idDoc || user.get("id") == id);
        
    User user = User(
      id: documents[i].get("id"),
      // idDoc: documents[i].get("idDoc"),
      tglDibuat: documents[i].get("tglDibuat").toDate(),
      username: documents[i].get("username"),
      namaLengkap: documents[i].get("namaLengkap"),
      email: documents[i].get("email"),
      password: documents[i].get("password"),
      foto: documents[i].get("foto"),
    );
    return user;
  }

  void addUser(User user) async {
    _usersRef.add({
      "id": await userCount + 1,
      "tglDibuat": user.tglDibuat,
      "username": user.username,
      "namaLengkap": user.namaLengkap,
      "email": user.email,
      "password": user.password,
      "foto": user.foto,
    });
    notifyListeners();
  }
}
