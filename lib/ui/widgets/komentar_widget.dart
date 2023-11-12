part of "widgets.dart";

class KomentarWidget extends StatelessWidget {
  Komentar komentar;
  KomentarWidget({super.key, required this.komentar});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserData>(context, listen: false)
        .users
        .where((user) => user.id == komentar.userId)
        .toList()[0];

    int authUserid = Provider.of<AuthData>(context).authUser.id;

    return Consumer<LikeData>(builder: (context, likeProvider, child,) {
      return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 80,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: Column(
                children: [
                  AccountButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        "/profile",
                        arguments: user,
                      );
                    },
                    image: user.foto!,
                  ),
                ],
              ),
            ),
            Container(
              width: width(context) - 80 - 60,
              // padding: EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user.username,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        " • ${DateFormat('dd MMM yyyy HH.mm')
                                .format(komentar.tglDibuat)}",
                        style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.bodySmall!.fontSize,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.5)),
                      ),
                    ],
                  ),
                  Text(
                    komentar.konten,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Container(
              width: 50,
              padding: const EdgeInsets.only(left: 10, right: 20),
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  if (!likeProvider.isLiked(
                    authUserid,
                    komentarId: komentar.id,
                  )) {
                    likeProvider.addlike(
                      Like(
                          id: likeProvider.likesCount + 1,
                          userId: authUserid,
                          komentarId: komentar.id),
                    );
                  } else {
                    likeProvider.deleteLike(
                      likeProvider.likes
                          .where((like) =>
                              like.userId == authUserid &&
                              like.komentarId == komentar.id)
                          .toList()[0],
                    );
                  }
                },
                icon: Icon(
                  likeProvider.isLiked(
                    authUserid,
                    komentarId: komentar.id,
                  )
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline,
                  size: 20,
                  color: likeProvider.isLiked(
                    authUserid,
                    komentarId: komentar.id,
                  )
                      ? colors["soft-pink"]
                      : Theme.of(context).colorScheme.primary,
                ),
                padding: EdgeInsets.zero,
              ),
            )
          ],
        ),
      );
    });
  }
}
