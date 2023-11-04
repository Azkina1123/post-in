part of "providers.dart";

class LikeProvider extends ChangeNotifier {
  final List<Like> _likes = [
    Like(id: 1, type: "post", userId: 2, postId: 4),
    Like(id: 2, type: "post", userId: 4, postId: 5),
    Like(id: 3, type: "post", userId: 1, postId: 5),
    Like(id: 4, type: "post", userId: 2, postId: 4),
    Like(id: 5, type: "post", userId: 3, postId: 4),
    Like(id: 6, type: "post", userId: 1, postId: 4),
    Like(id: 7, type: "post", userId: 4, postId: 5),
    Like(id: 8, type: "post", userId: 5, postId: 4),
  ];

  UnmodifiableListView get likes {
    return UnmodifiableListView(_likes);
  }

  int get likeCount {
    return _likes.length;
  }

  void addlike(Like like) {
    _likes.add(like);
    notifyListeners();
  }

  void deleteLike(Like like) {
    _likes.remove(like);
    notifyListeners();
  }

  int getLikesNumber({int? postId, int? komentarId}) {
    return _likes
        .where(((like) {
          if (komentarId == null) {
            return like.postId == postId;
          } else if (postId == null) {
            return like.userId == komentarId;
          }
          return false;
        }))
        .toList()
        .length;
  }

  bool isLiked(int userId, int postId) {
    return _likes.where(((like) => like.userId == userId && like.postId == postId)).toList().isNotEmpty;
  }
}
