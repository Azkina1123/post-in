part of "providers.dart";

class PageData extends ChangeNotifier {
  int mainIndex = 0;

  void changeMainPage(int index) {
    mainIndex = index;
    notifyListeners();
  }

  int homeIndex = 0;
  void changeHomePage(int index) {
    homeIndex = index;
    notifyListeners();
  }

  // focus tambah komentar ketika buka post page
  bool _komentarFocused = false;
  bool get komentarFocused => _komentarFocused;

  void changeKomentarFocus(bool value) {
    _komentarFocused = value;
    notifyListeners();
  }

  // snackbar hapus komentar
  bool _onSnackBar = false;
  bool get onSnackBar => _onSnackBar;

  void openSnackBar() {
    _onSnackBar = true;
  }

  void closeSnackBar() {
    _onSnackBar = false;
  }
}
