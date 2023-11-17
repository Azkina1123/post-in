part of "widgets.dart";

class PostWidget extends StatelessWidget {
  Post post;

  User? user;
  // String? postIdDoc;
  PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    int authUserid = Provider.of<AuthData>(context).authUser.id;

    return Consumer2<LikeData, KomentarData>(
        builder: (context, likeData, komentarData, child) {
      return Container(
        width: width(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: Provider.of<UserData>(context, listen: false)
                    .usersRef
                    .where("id", isEqualTo: post.userId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!.docs;
                    user = User(
                      id: data[0].get("id"),
                      docId: data[0].id,
                      tglDibuat: data[0].get("tglDibuat").toDate(),
                      username: data[0].get("username"),
                      namaLengkap: data[0].get("namaLengkap"),
                      email: data[0].get("email"),
                      gender: data[0].get("gender"),
                      noTelp: data[0].get("noTelp"),
                      password: data[0].get("password"),
                      foto: data[0].get("foto"),
                      sampul: data[0].get("sampul"),
                    );
                    return ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/profile",
                          arguments: user,
                        );
                      },
                      splashColor: Colors.transparent,
                      leading: AccountButton(
                        onPressed: null,
                        image: NetworkImage(user!.foto),
                      ),
                      title: Text(user!.username,
                          style: Theme.of(context).textTheme.titleMedium),
                      subtitle: Text(
                        DateFormat('dd MMM yyyy HH.mm').format(post.tglDibuat),
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.5),
                          fontSize:
                              Theme.of(context).textTheme.bodySmall!.fontSize,
                        ),
                      ),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: 'delete',
                              child: const Text('Delete'),
                              onTap: () {
                                showDeleteDialog(context);
                              },
                            )
                          ];
                        },
                      ),
                    );
                  }

                  return const Text("");
                }),
            InkWell(
              onTap: ModalRoute.of(context)!
                                              .settings
                                              .name == "/" ? () {
                Navigator.pushNamed(context, "/post", arguments: post);
              } : null,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    post.img != null
                        ? Container(
                            width: width(context),
                            height: 200,
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(post.img!),
                                  fit: BoxFit.cover),
                            ),
                          )
                        : const Text(""),

                    Text(
                      post.konten,
                    ),
                    const SizedBox(height: 10,),

                    // like dan komentar ----------------------------------------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // tombol like -------------------------------------------------------
                        SizedBox(
                          width: 70,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: likeData.likesRef
                                  .where("postId", isEqualTo: post.id)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    width: width(context),
                                    alignment: Alignment.center,
                                    child: const CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasData) {
                                  final likes = snapshot.data!.docs;

                                  bool isLiked = likes
                                      .where(
                                        (like) =>
                                            like.get("userId") == authUserid &&
                                            like.get("postId") == post.id,
                                      )
                                      .isNotEmpty;

                                  int likeCount = likes.length;

                                  return TextButton.icon(
                                    onPressed: () async {
                                      if (!isLiked) {
                                        likeData.add(
                                          Like(
                                            id: 1,
                                            userId: authUserid,
                                            postId: post.id,
                                          ),
                                        );

                                        Provider.of<PostData>(context,
                                                listen: false)
                                            .updateTotalLike(
                                          post.docId!,
                                          likeCount + 1,
                                        );
                                      } else {
                                        String id = likes
                                            .firstWhere((like) =>
                                                like.get("userId") ==
                                                authUserid)
                                            .id;
                                        likeData.delete(id);
                                        Provider.of<PostData>(context,
                                                listen: false)
                                            .updateTotalLike(
                                          post.docId!,
                                          likeCount - 1,
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      isLiked
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_outline,
                                      color: isLiked
                                          ? colors["soft-pink"]
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                    ),
                                    style:
                                        Theme.of(context).textButtonTheme.style,
                                    label: Text(
                                      likeCount.toString(),
                                      style: TextStyle(
                                        color: isLiked
                                            ? colors["soft-pink"]
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
                                      ),
                                    ),
                                  );
                                }
                                return const Text("");
                              }),
                        ),

                        // tombol komentar -------------------------------------------------------
                        SizedBox(
                          width: 70,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: komentarData.komentarsRef
                                  .where("postId", isEqualTo: post.id)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // return Container(
                                  //   width: width(context),
                                  //   alignment: Alignment.center,
                                  //   child: const CircularProgressIndicator(),
                                  // );
                                } else if (snapshot.hasData) {
                                  final komentarCount = snapshot.data!.size;
                                  return TextButton.icon(
                                    onPressed: () {
                                      // jika berada di halaman home,
                                      // jike tekan tombol komentar, maka akan dialihkan ke,
                                      // halaman post dan textfield komentar dalam mode focus,
                                      // if (ModalRoute.of(context)!.settings.name == "/" || ModalRoute.of(context)!.settings.name == "/profile") {
                                      if (ModalRoute.of(context)!
                                              .settings
                                              .name !=
                                          null) {
                                        Provider.of<PageData>(context,
                                                listen: false)
                                            .changeRoute("/post");
                                        Navigator.pushNamed(
                                          context,
                                          "/post",
                                          arguments: post,
                                        );
                                      }

                                      // focus kan komentar
                                      Provider.of<PageData>(context,
                                              listen: false)
                                          .changeKomentarFocus(true);
                                    },
                                    icon: const Icon(Icons.mode_comment_outlined),
                                    style:
                                        Theme.of(context).textButtonTheme.style,
                                    label: Text(komentarCount.toString()),
                                  );
                                }
                                return const Text("");
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<dynamic> showDeleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Peringatan!"),
            content: const Text("Apakah Anda yakin ingin menghapus post ini?"),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Batalkan"),
              ),
              ElevatedButton(
                onPressed: () async {
                  int authUserId = Provider.of<AuthData>(context, listen: false).authUser.id;

                  Provider.of<PostData>(context, listen: false)
                      .delete(post.docId!);

                  // hapus like
                  final likeData =
                      Provider.of<LikeData>(context, listen: false);
                  Like like = await likeData.getLike(
                    authUserId,
                    postId: post.id,
                  );
                  likeData.delete(like.docId!);

                  // hapus komentar
                  final komentarData =
                      Provider.of<KomentarData>(context, listen: false);
                  List<Komentar> komentars =
                      await komentarData.getKomentars(postId: post.id);
                  komentars.forEach((komentar) {
                    komentarData.delete(komentar.docId!);
                  });

                  Navigator.of(context).pop();
                },
                child: const Text("Ya"),
              ),
            ],
          );
        });
  }
  // void _getUser(BuildContext context) async {
  //   user = await Provider.of<UserData>(context, listen: false)
  //       .getUser(post.userId);
  // }
}
