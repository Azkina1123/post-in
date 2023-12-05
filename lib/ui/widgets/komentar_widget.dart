part of "widgets.dart";

class KomentarWidget extends StatefulWidget {
  Komentar komentar;
  String? postId;

  KomentarWidget({super.key, required this.komentar, this.postId});

  @override
  State<KomentarWidget> createState() => _KomentarWidgetState();
}

class _KomentarWidgetState extends State<KomentarWidget> {
  UserAcc? _user;
  bool _selected = false;
  bool _successDelete = false;
  SnackBar? sn;

  @override
  Widget build(BuildContext context) {
    final komentarData = Provider.of<KomentarData>(context, listen: false);
    _selected = komentarData.selectedKomentar.contains(widget.komentar.id);

    String authUserId = FirebaseAuth.instance.currentUser!.uid;
    bool isLiked = widget.komentar.likes.contains(authUserId);

    bool onUserProfilePage = false;
    if (ModalRoute.of(context)!.settings.name == "/profile") {
      onUserProfilePage =
          (ModalRoute.of(context)!.settings.arguments as UserAcc).id ==
              widget.komentar.userId;
    }

    return InkWell(
      // jika menekan komentar, muncul snackbar ===========================================================
      onTap: widget.komentar.userId == authUserId
          ? () {
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
                        ScaffoldMessenger.of(context).clearSnackBars();

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
              // if (snapshot.hasData) {

              // }
                _user = snapshot.data;

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
                            onPressed: onUserProfilePage
                                ? null
                                : () {
                                    Navigator.pushNamed(
                                      context,
                                      "/profile",
                                      arguments: _user!,
                                    );
                                  },
                            image: NetworkImage(_user?.foto ?? ""),
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

                              SizedBox(
                                width: (_user?.username.length ?? 0) > 14
                                    ? width(context) - 80 - 60 - 135
                                    : null,
                                child: Text(
                                  _user?.username ?? "",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                " • ${getDifferenceTime()}",
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
                    StreamBuilder<QuerySnapshot>(
                      stream: Provider.of<KomentarData>(context, listen: false)
                            .komentarsCollection
                            .where("id", isEqualTo: widget.komentar.id)
                            .snapshots(),
                      builder: (context, snapshot) {
                        Komentar? getKomentar = !snapshot.hasData
                              ? null
                              : Komentar.fromJson(snapshot.data!.docs[0].data()
                                  as Map<String, dynamic>);
                          bool isLiked = getKomentar == null
                              ? false
                              : getKomentar.likes.contains(
                                  FirebaseAuth.instance.currentUser!.uid);

                        return Column(
                          children: [
                            IconButton(
                              onPressed: () async {
                                Provider.of<KomentarData>(context, listen: false)
                                    .toggleLike(getKomentar!.id);
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
                              getKomentar != null &&
                              getKomentar.likes.isNotEmpty
                                  ? getKomentar.likes.length.toString()
                                  : "",
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.visible,
                            )
                          ],
                        );
                      }
                    ),
                  
                  ],
                );
              
              // return Text("");
            }),
      ),
    );
  }

  String getDifferenceTime() {
    int detik = widget.komentar.tglDibuat.difference(DateTime.now()).inSeconds.abs();

    if (detik < 60) {
      return "$detik detik yang lalu";
    } else if (detik < 3600) {
      int menit = (detik / 60).floor();
      return "$menit menit yang lalu";
    } else if (detik < 3600 * 24) {
      int jam = (detik / 3600).floor();
      return "$jam jam yang lalu";
    } else {
      return DateFormat('dd MMM yyyy HH.mm').format(widget.komentar.tglDibuat);
    }
  }
}
