part of "providers.dart";

class PageProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool _komentarFocused = false;
  bool get komentarFocused => _komentarFocused;

  void changePage(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void changeKomentarFocus(bool value) {
    _komentarFocused = value;
    notifyListeners();
  }
}
