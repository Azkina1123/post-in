part of "providers.dart";

class AuthData extends ChangeNotifier {
  User? _authUser = User(
    id: 1,
    username: "alu",
    namaLengkap: "Muhammad Alucard",
    email: "alu.ml@gmail.com",
    password: "alufeed",
    foto: NetworkImage(
        "https://static.wikia.nocookie.net/mobile-legends/images/a/a4/Hero051-portrait.png"),
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
