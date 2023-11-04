part of "providers.dart";

class KomentarProvider extends ChangeNotifier {
  final List<Komentar> _komentars = [
    Komentar(
      id: 1,
      tglDibuat: DateTime.utc(2023, 11, 1, 2, 55),
      konten:
          "Selamat ulang tahun, sahabat! Semoga semua hari-harimu penuh dengan cinta dan kebahagiaan. 🎂❤️",
      postId: 1,
      userId: 1,
    ),
    Komentar(
      id: 2,
      tglDibuat: DateTime.utc(2023, 11, 2),
      konten:
          "Selamat ulang tahun! Semoga usiamu semakin berharga dan penuh dengan momen-momen indah. 🎂✨",
      postId: 2,
      userId: 1,
    ),
    Komentar(
      id: 3,
      tglDibuat: DateTime.utc(2023, 11, 2),
      konten:
          "Selamat ulang tahun, teman! Semoga hidupmu dihiasi dengan senyuman dan cinta. 🎁🌟",
      postId: 1,
      userId: 1,
    ),
    Komentar(
      id: 4,
      tglDibuat: DateTime.utc(2023, 11, 3),
      konten: "Siapa itu gak ada kenal aku 😒😒🤔",
      postId: 2,
      userId: 1,
    ),
    Komentar(
      id: 5,
      tglDibuat: DateTime.utc(2023, 11, 4, 07, 11),
      konten: "💕💕💕💕💕",
      postId: 3,
      userId: 1,
    ),
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
    sortKomentarbyDateDesc();
  }

  void sortKomentarbyDateDesc() {
    _komentars.sort((a, b) {
      return b.tglDibuat.compareTo(a.tglDibuat);
    });
    notifyListeners();
  }

  List<Komentar> getKomentars({int? postId, int? userId}) {
    return _komentars.where(((komentar) {
      if (userId == null) {
        return komentar.postId == postId;
      } else if (postId == null) {
        return komentar.userId == userId;
      } else {
        return komentar.postId == postId && komentar.userId == userId;
      }
    })).toList();
  }

  int getKomentarsNumber({int? postId, int? userId}) {
    return getKomentars(postId: postId, userId: userId).length;
  }

  int totalKomentar(int postId) {
    return _komentars
        .where(
          ((komentar) => komentar.postId == postId),
        )
        .toList()
        .length;
  }

  // void sortKomentarByDateDesc() {
  //   _komentars.sort(
  //     (a, b) {
  //       return b.tglDibuat.compareTo(a.tglDibuat);
  //     },
  //   );
  //   notifyListeners();
  // }
}
