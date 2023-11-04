part of "providers.dart";

class LikeProvider extends ChangeNotifier {
  final List<Like> _likes = [
    Like(id: 1, userId: 2, postId: 4),
    Like(id: 2, userId: 4, postId: 5),
    Like(id: 3, userId: 1, postId: 5),
    Like(id: 4, userId: 2, postId: 4),
    Like(id: 5, userId: 3, postId: 4),
    Like(id: 6, userId: 1, postId: 4),
    Like(id: 7, userId: 4, postId: 5),
    Like(id: 8, userId: 5, postId: 4),
  ];

  UnmodifiableListView get likes {
    return UnmodifiableListView(_likes);
  }

  int get likesCount {
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

  bool isLiked(int userId, {int? postId, int? komentarId}) {
    return _likes
        .where(
          ((like) {
            if (komentarId == null) {
              return like.userId == userId && like.postId == postId;
            } else if (postId == null) {
              return like.userId == userId && like.komentarId == komentarId;
            }
            return true;
          }),
        )
        .toList()
        .isNotEmpty;
  }

  int totalLikes(int postId) {
    return _likes
        .where(
          ((like) => like.postId == postId),
        )
        .toList()
        .length;
  }


}
