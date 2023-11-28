part of "widgets.dart";

class KomentarWidget extends StatefulWidget {
  Komentar komentar;
  int postId;

  KomentarWidget({super.key, required this.komentar, required this.postId});

  @override
  State<KomentarWidget> createState() => _KomentarWidgetState();
}

class _KomentarWidgetState extends State<KomentarWidget> {
  Userdata? _user;
  bool _selected = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? authUserId = Provider.of<Auth>(context, listen: false).id_now;

    return Consumer<LikeData>(builder: (context, likeData, child) {
      return InkWell(
        // jika menekan komentar, muncul snackbar ===========================================================
        onTap: widget.komentar.userId == authUserId
            ? () {
                setState(() {
                  _selected = !_selected;

                  if (_selected) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Hapus komentar ini?"),
                        action: SnackBarAction(
                          label: "Ya",
                          onPressed: () async {
                            final komentarData = Provider.of<KomentarData>(
                                context,
                                listen: false);
                            final postData =
                                Provider.of<PostData>(context, listen: false);

                            Post post = await postData.getPost(widget.postId);

                            komentarData.delete(widget.komentar.id);

                            postData.updateTotalKomentar(
                              post.docId!,
                              await komentarData.getKomentarCount(post.id),
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

        // tampilan komentar ===========================================================
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: _selected
                ? colors["sand"]!.withOpacity(0.3)
                : Theme.of(context).colorScheme.surface,
          ),
          child: FutureBuilder<Userdata>(
              future: Provider.of<UserData>(context, listen: false)
                  .getUser(widget.komentar.userId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _user = snapshot.data!;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // foto user ------------------------------------------------------
                      Container(
                        width: 80,
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 15, right: 10),
                        child: Column(
                          children: [
                            // AccountButton(
                            //   onPressed: () {
                            //     Navigator.pushNamed(
                            //       context,
                            //       "/profile",
                            //       arguments: _user,
                            //     );
                            //   },
                            //   image: NetworkImage(_user!.foto),
                            // ),
                          ],
                        ),
                      ),

                      // body komentar ------------------------------------------------------

                      SizedBox(
                        width: width(context) - 80 - 60,
                        // padding: EdgeInsets.only(right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // username & tanggal ------------------------------------------------------
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

                            // isi komentar ------------------------------------------------------
                            Text(
                              widget.komentar.konten,
                              softWrap: true,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),

                      // like komentar ------------------------------------------------------
                      Container(
                        width: 50,
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        alignment: Alignment.topRight,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: likeData.likesRef
                              .where("komentarId",
                                  isEqualTo: widget.komentar.id)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final data = snapshot.data!.docs;
                              bool isLiked = data
                                  .where((like) =>
                                      like.get("userId") == authUserId)
                                  .isNotEmpty;
                              return Column(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      if (!isLiked) {
                                        likeData.add(
                                          Like(
                                            id: 1,
                                            userId: authUserId,
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
                                    style: const TextStyle(fontSize: 12),
                                  )
                                ],
                              );
                            }
                            return const Text("");
                          },
                        ),
                      )
                    ],
                  );
                }

                return Container(
                  width: width(context),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }),
        ),
      );
    });
  }
}
