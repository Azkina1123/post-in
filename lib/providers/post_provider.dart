part of "providers.dart";

class PostProvider extends ChangeNotifier {
  final List<Post> _posts = [
    Post(
      id: 1,
      tglDibuat: DateTime.utc(2023, 5, 22, 7, 00),
      konten:
          "Selamat ulang tahun yang ke-25, [nama teman]! Semoga hari ini penuh kebahagiaan dan keberuntungan. Semoga semua impianmu terwujud. 🎂🎉, #UlangTahun #TemanTerbaik",
      userId: 3,
      totalKomentar: 2,
      totalLike: 0,
    ),
    Post(
      id: 2,
      tglDibuat: DateTime.utc(2023, 5, 30, 23, 12),
      konten:
          "Hari pertama liburan di [nama destinasi]! Pemandangan luar biasa dan cuaca cerah. Bersama [nama teman/keluarga] siap menjelajahi petualangan ini. 🏝️☀️ #LiburanSeru #Petualangan",
      userId: 1,
      img: NetworkImage("https://picsum.photos/800/500"),
      totalKomentar: 2,
      totalLike: 0,
    ),
    Post(
      id: 3,
      tglDibuat: DateTime.utc(2023, 8, 2, 17, 54),
      konten:
          "Cuaca cerah hari ini, matahari bersinar terang! Semoga hari ini penuh semangat. ☀️ #CuacaBagus #Semangat",
      userId: 2,
      totalKomentar: 1,
      totalLike: 0,
    ),
    Post(
      id: 4,
      tglDibuat: DateTime.utc(2023, 10, 11, 11, 22),
      konten:
          "Senang mengumumkan bahwa saya berhasil menyelesaikan proyek [nama proyek] hari ini! Terima kasih kepada semua yang telah mendukung saya. 💪🎉 #Pencapaian #ProyekSelesai",
      userId: 5,
      img: NetworkImage("https://picsum.photos/800/400"),
      totalKomentar: 0,
      totalLike: 5,
    ),
    Post(
      id: 5,
      tglDibuat: DateTime.utc(2023, 11, 1, 4, 29),
      konten:
          "Keindahan alam yang menenangkan. Saya merasa beruntung bisa melihat pemandangan seperti ini. 🏞️❤️ #PemandanganAlam #Kedamaian",
      userId: 4,
      totalKomentar: 0,
      totalLike: 3,
    ),
  ];

  UnmodifiableListView<Post> get posts {
    return UnmodifiableListView(_posts);
  }

  int get postCount {
    return _posts.length;
  }

  void addPost(Post post) {
    _posts.add(post);
    notifyListeners();
  }

  void updatePost(Post post) {
    // post.tog
    notifyListeners();
  }

  void deletePost(Post post) {
    _posts.remove(post);
    notifyListeners();
  }

  void like(Post post) {
    post.like();
    notifyListeners();
  }

  void unlike(Post post) {
    post.unlike();
    notifyListeners();
  }

  void sortByDateDesc() {
    _posts.sort((a, b) {
      return b.tglDibuat.compareTo(a.tglDibuat);
    });
    notifyListeners();
  }

  void sortByPopularityDesc() {
    _posts.sort((a, b) {

      
      return (b.totalLike+b.totalKomentar).compareTo(a.totalLike + a.totalKomentar);
    });
    notifyListeners();

  }

  final List<Post> _followedPosts = [];
  UnmodifiableListView<Post> get followedPosts {
    return UnmodifiableListView(_followedPosts);
  }

  int get followedPostsCount {
    return _followedPosts.length;
  }

  void addFollowedPosts(int userIdFollowed) {
    List<Post> followedPosts =
        _posts.where((post) => post.userId == userIdFollowed).toList();
    for (Post post in followedPosts) {
      if (!_followedPosts.contains(post)) {
      _followedPosts.add(post);

      }
    }
    notifyListeners();
  }

  // List<Post> getPostByUser(int userId) {
  //   return _posts.where((post) => post.userId == userId).toList();
  // }
}
