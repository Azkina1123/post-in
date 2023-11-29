part of "widgets.dart";

class KomentarWidget extends StatefulWidget {
  Komentar komentar;
  String postId;

  KomentarWidget({super.key, required this.komentar, required this.postId});

  @override
  State<KomentarWidget> createState() => _KomentarWidgetState();
}

class _KomentarWidgetState extends State<KomentarWidget> {
  UserAcc? _user;
  bool _selected = false;
  bool _successDelete = false;

  @override
  Widget build(BuildContext context) {
    String authUserId = FirebaseAuth.instance.currentUser!.uid;
    bool isLiked = widget.komentar.likes.contains(authUserId);

    return InkWell(
      // jika menekan komentar, muncul snackbar ===========================================================
      onTap: widget.komentar.userId == authUserId
          ? () {
              final komentarData =
                  Provider.of<KomentarData>(context, listen: false);
              setState(() {
                komentarData.toggleSelectKomentar(widget.komentar.id);
                _selected =
                    komentarData.selectedKomentar.contains(widget.komentar.id);
              });

              if (komentarData.selectedKomentar.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Hapus komentar ini?"),
                    action: SnackBarAction(
                      label: "Ya",
                      onPressed: () {
                        _successDelete = true;
                        komentarData.delete();

                        setState(() {
                          if (_successDelete) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Komentar berhasil dihapus!")));
                            _successDelete = false;
                          }
                        });
                      },
                    ),
                    duration: const Duration(days: 1),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).clearSnackBars();
              }
            }
          : null,

      // tampilan komentar ===========================================================
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: _selected!
              ? colors["sand"]!.withOpacity(0.2)
              : Theme.of(context).colorScheme.surface,
        ),
        child: FutureBuilder<UserAcc>(
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
                          AccountButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                "/profile",
                                arguments: _user,
                              );
                            },
                            image: NetworkImage(_user!.foto!),
                          ),
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
                                style: Theme.of(context).textTheme.titleMedium,
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
                    Column(
                      children: [
                        IconButton(
                          onPressed: () async {
                            widget.komentar.toggleLike(context);
                          },
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
                        ),
                        Text(
                          widget.komentar.likes.isNotEmpty
                              ? widget.komentar.likes.length.toString()
                              : "",
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    ),
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
  }
}
