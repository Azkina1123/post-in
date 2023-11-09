part of "providers.dart";

class UserData extends ChangeNotifier {
  final List<User> _users = [
    User(
      id: 1,
      username: "alu",
      namaLengkap: "Muhammad Alucard",
      email: "alu.ml@gmail.com",
      password: "alufeed",
      foto: NetworkImage(
          "https://static.wikia.nocookie.net/mobile-legends/images/a/a4/Hero051-portrait.png"),
    ),
    User(
      id: 2,
      username: "azkina1123",
      namaLengkap: "Aziizah Oki",
      email: "azzz@gmail.com",
      password: "hehe",
      foto: const NetworkImage(
        "https://avatars.githubusercontent.com/Azkina1123",
      ),
    ),
    User(
      id: 3,
      username: "Aliyairfani",
      namaLengkap: "Aliya Irfani",
      email: "aliyaff@gmail.com",
      password: "nice",
      foto: const NetworkImage(
        "https://avatars.githubusercontent.com/Aliyairfani",
      ),
    ),
    User(
      id: 4,
      username: "Chintialiuw",
      namaLengkap: "Chintia Liu",
      email: "chinnnt@gmail.com",
      password: "good",
      foto: const NetworkImage(
        "https://avatars.githubusercontent.com/Chintialiuw",
      ),
    ),
    User(
      id: 5,
      username: "Venomz22",
      namaLengkap: "Dimas Arya",
      email: "dann@gmail.com",
      password: "awesome",
      foto: const NetworkImage(
        "https://avatars.githubusercontent.com/Venomz22",
      ),
    ),

  ];

  UnmodifiableListView get users {
    return UnmodifiableListView(_users);
  }

  int get userCount {
    return _users.length;
  }

  void addKomentar(User user) {
    _users.add(user);
    notifyListeners();
  }
}
