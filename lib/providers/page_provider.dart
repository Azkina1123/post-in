part of "providers.dart";

class PageProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changePage(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  String _currentRoute = "/";
  String get currentRoute => _currentRoute;
  void changeRoute(String route) {
    _currentRoute = route;
    notifyListeners();
  }

  // focus tambah komentar ketika buka post page
  bool _komentarFocused = false;
  bool get komentarFocused => _komentarFocused;

  void changeKomentarFocus(bool value) {
    _komentarFocused = value;
    notifyListeners();
  }
}
