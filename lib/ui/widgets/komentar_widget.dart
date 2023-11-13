part of "widgets.dart";

class KomentarWidget extends StatelessWidget {
  Komentar komentar;
  KomentarWidget({super.key, required this.komentar});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthData>(context).authUser;

    int authUserid = Provider.of<AuthData>(context).authUser.id;

    return Consumer<LikeData>(builder: (
      context,
      likeData,
      child,
    ) {
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
                    image: NetworkImage(user.foto!),
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
                        " • ${DateFormat('dd MMM yyyy HH.mm').format(komentar.tglDibuat)}",
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
              child: StreamBuilder<QuerySnapshot>(
                  stream: likeData.likes
                      .where("komentarId", isEqualTo: komentar.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final likes = snapshot.data!;
                      bool isLiked = likes.docs.isNotEmpty;

                      return IconButton(
                        onPressed: () async {
                          if (!isLiked) {
                            likeData.addlike(
                              Like(
                                id: 1,
                                userId: authUserid,
                                komentarId: komentar.id,
                              ),
                            );
                          } else {
                            for (QueryDocumentSnapshot document in likes.docs) {
                              if (document.get("userId") == authUserid) {
                                await document.reference.delete();
                              }
                            }
                          }
                        },
                        // icon: Icon(Icons.favorite_rounded),
                        icon: Icon(
                          isLiked
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline,
                          size: 20,
                          color: isLiked
                              ? colors["soft-pink"]
                              : Theme.of(context).colorScheme.primary,
                        ),
                        padding: EdgeInsets.zero,
                      );
                    }
                    return const Text("");
                  }),
            ),
          ],
        ),
      );
    });
  }
}
