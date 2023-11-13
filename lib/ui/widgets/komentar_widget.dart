part of "widgets.dart";

class KomentarWidget extends StatelessWidget {
  Komentar komentar;
  int postId;
  User? user;
  KomentarWidget({super.key, required this.komentar, required this.postId});

  @override
  Widget build(BuildContext context) {
    int authUserid = Provider.of<AuthData>(context).authUser.id;

    return Consumer<LikeData>(builder: (context, likeData, child) {
      return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: StreamBuilder<QuerySnapshot>(
            stream: Provider.of<UserData>(context)
                .usersRef
                .where("id", isEqualTo: komentar.userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                QuerySnapshot data = snapshot.data!;
                user = User(
                  id: data.docs[0].get("id"),
                  tglDibuat: data.docs[0].get("tglDibuat").toDate(),
                  username: data.docs[0].get("username"),
                  namaLengkap: data.docs[0].get("namaLengkap"),
                  email: data.docs[0].get("email"),
                  password: data.docs[0].get("password"),
                  foto: data.docs[0].get("foto"),
                );
                return Row(
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
                            image: NetworkImage(user!.foto),
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
                                user!.username,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                " • ${DateFormat('dd MMM yyyy HH.mm').format(komentar.tglDibuat)}",
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .fontSize,
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
                                    Provider.of<KomentarData>(context,
                                            listen: false)
                                        .updateTotalLikeKomentar(
                                      komentar.idDoc!,
                                      komentar.totalLike + 1,
                                    );
                                  } else {
                                    likeData.deleteLike(likes.docs[0].id);
                                    Provider.of<KomentarData>(context,
                                            listen: false)
                                        .updateTotalLikeKomentar(
                                      komentar.idDoc!,
                                      komentar.totalLike - 1,
                                    );
                                  }

                                  Provider.of<KomentarData>(context,
                                          listen: false)
                                      .updateTotalLikeKomentar(
                                    komentar.idDoc!,
                                    komentar.totalLike,
                                  );
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
                );
              }

              return const Text("");
            }),
      );
    });
  }
}
