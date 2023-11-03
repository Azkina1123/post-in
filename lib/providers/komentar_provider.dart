part of "providers.dart";

class KomentarProvider extends ChangeNotifier {
  final List<Komentar> _komentars = [
    
  ];

  UnmodifiableListView get komentars {
    return UnmodifiableListView(_komentars);
  }

  int get komentarCount {
    return _komentars.length;
  }

  void addKomentar(Komentar komentar) {
    _komentars.add(komentar);
    notifyListeners();
  }
}
