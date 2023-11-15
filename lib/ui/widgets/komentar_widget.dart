part of "widgets.dart";

class KomentarWidget extends StatefulWidget {
  Komentar komentar;
  int postId;

  KomentarWidget({super.key, required this.komentar, required this.postId});

  @override
  State<KomentarWidget> createState() => _KomentarWidgetState();
}

class _KomentarWidgetState extends State<KomentarWidget> {
  User? _user;
  bool _selected = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int authUserid = Provider.of<AuthData>(context, listen: false).authUser.id;

    return Consumer<LikeData>(builder: (context, likeData, child) {
      return InkWell(
        onTap: widget.komentar.userId == authUserid
            ? () {
                setState(() {
                  _selected = !_selected;

                  // final pageData =
                  //     Provider.of<PageData>(context, listen: false);
                  // if (_selected) {
                  //   pageData.openSnackBar();
                  // } else {
                  //   pageData.closeSnackBar();
                  // }

                  if (_selected) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Hapus komentar ini?"),
                        action: SnackBarAction(
                          label: "Ya",
                          onPressed: () async {
                            Post post = await Provider.of<PostData>(context,
                                    listen: false)
                                .getPost(widget.postId);
                            Provider.of<KomentarData>(context, listen: false)
                                .delete(widget.komentar.docId!);
                            Provider.of<PostData>(context, listen: false)
                                .updateTotalKomentar(
                              post.docId!,
                              post.totalKomentar - 1,
                            );
                            _selected = false;
                          },
                        ),
                        duration: const Duration(days: 1),

                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).clearSnackBars();
                  }
                });
              }
            : null,
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: _selected
                ? colors["sand"]!.withOpacity(0.3)
                : Theme.of(context).colorScheme.surface,
          ),
          child: StreamBuilder<QuerySnapshot>(
              stream: Provider.of<UserData>(context)
                  .usersRef
                  .where("id", isEqualTo: widget.komentar.userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!.docs;
                  _user = User(
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
                                  arguments: _user,
                                );
                              },
                              image: NetworkImage(_user!.foto),
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
                                  _user!.username,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  " • ${DateFormat('dd MMM yyyy HH.mm').format(widget.komentar.tglDibuat)}",
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
                              widget.komentar.konten,
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
                          stream: likeData.likesRef
                              .where("komentarId",
                                  isEqualTo: widget.komentar.id)
                              .where("userId", isEqualTo: authUserid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final data = snapshot.data!.docs;
                              bool isLiked = data.isNotEmpty;
                              return Column(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      if (!isLiked) {
                                        likeData.add(
                                          Like(
                                            id: 1,
                                            userId: authUserid,
                                            komentarId: widget.komentar.id,
                                          ),
                                        );
                                        Provider.of<KomentarData>(context,
                                                listen: false)
                                            .updateTotalLike(
                                          widget.komentar.docId!,
                                          widget.komentar.totalLike + 1,
                                        );
                                      } else {
                                        likeData.delete(data[0].id);
                                        Provider.of<KomentarData>(context,
                                                listen: false)
                                            .updateTotalLike(
                                          widget.komentar.docId!,
                                          widget.komentar.totalLike - 1,
                                        );
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
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  Text(
                                    widget.komentar.totalLike != 0
                                        ? widget.komentar.totalLike.toString()
                                        : "",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              );
                            }
                            return Text("");
                          },
                        ),
                      )
                    ],
                  );
                }

                return const Text("");
              }),
        ),
      );
    });
  }
}
