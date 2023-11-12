part of "providers.dart";

class AuthData extends ChangeNotifier {
  User? _authUser = User(
    id: 1,
    tglDibuat: DateTime.now(),
    username: "alu",
    namaLengkap: "Muhammad Alucard",
    email: "alu.ml@gmail.com",
    password: "alufeed",
    foto: NetworkImage(
        "https://www.ligagame.tv/images/Nana-Hero-Mobile-Legends_4f22c.jpg"),
  );

  User get authUser => _authUser!;

  void login(User user) {
    _authUser = user;
    notifyListeners();
  }

  void logout() {
    _authUser = null;
    notifyListeners();
  }
}
