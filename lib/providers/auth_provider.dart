part of "providers.dart";

class AuthProvider extends ChangeNotifier {
  User? _authUser;

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
