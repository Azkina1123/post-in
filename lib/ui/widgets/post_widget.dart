part of "widgets.dart";

class PostWidget extends StatelessWidget {
  Post post;
  UserAcc? user;

  PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    String authUserId = FirebaseAuth.instance.currentUser!.uid;

    bool onUserProfilePage = false;
    if (ModalRoute.of(context)!.settings.name == "/profile") {
      onUserProfilePage =
          (ModalRoute.of(context)!.settings.arguments as UserAcc).id ==
              post.userId;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<UserAcc>(
          future: Provider.of<UserData>(context, listen: false)
              .getUser(post.userId),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              user = snapshot.data!;
            }
            return ListTile(
              onTap: onUserProfilePage
                  ? null
                  : () {
                      Navigator.pushNamed(
                        context,
                        "/profile",
                        arguments: user!,
                      );
                    },
              splashColor: Colors.transparent,
              leading: AccountButton(
                onPressed: null,
                image: NetworkImage(user?.foto ?? ""),
              ),
              title: Text(
                user?.username ?? "",
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                // DateFormat('dd MMM yyyy HH.mm').format(post.tglDibuat),
                getDifferenceTime(),
                style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                ),
              ),
              trailing: post.userId == authUserId
                  ? PopupMenuButton(
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
                    )
                  : null,
            );
          }),
        ),
        InkWell(
          onTap: ModalRoute.of(context)!.settings.name == "/post"
              ? null
              : () {
                  Navigator.pushNamed(context, "/post", arguments: post.id);
                },
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                post.img != null
                    ? InkWell(
                        onTap:
                            ModalRoute.of(context)!.settings.name == "/post" &&
                                    post.img != null
                                ? () => showImgDialog(context)
                                : null,
                        child: Container(
                          width: width(context),
                          height: 200,
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(post.img!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(height:0),

                ModalRoute.of(context)!.settings.name == "/post"
                    ? Text(
                        post.konten,
                      )
                    : Text(
                        post.konten,
                        maxLines: 5,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),

                const SizedBox(
                  height: 10,
                ),

                // like dan komentar ----------------------------------------------------------
                StreamBuilder<QuerySnapshot>(
                    stream: Provider.of<PostData>(context, listen: false)
                        .postsCollection
                        .where("id", isEqualTo: post.id)
                        .snapshots(),
                    builder: (context, snapshot) {
                      Post? getPost = !snapshot.hasData
                          ? null
                          : Post.fromJson(snapshot.data!.docs[0].data()
                              as Map<String, dynamic>);
                      bool isLiked = getPost == null
                          ? false
                          : getPost.likes
                              .contains(FirebaseAuth.instance.currentUser!.uid);

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // tombol like -------------------------------------------------------
                          TextButton.icon(
                            onPressed: () {
                              Provider.of<PostData>(context, listen: false)
                                  .toggleLike(getPost!.id);
                            },
                            icon: Icon(
                              isLiked
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_outline,
                              color: isLiked
                                  ? colors["soft-pink"]
                                  : Theme.of(context).colorScheme.primary,
                            ),
                            style: Theme.of(context).textButtonTheme.style,
                            label: Text(
                              (getPost != null ? getPost.totalLike : "").toString(),
                              style: TextStyle(
                                color: isLiked
                                    ? colors["soft-pink"]
                                    : Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),

                          // tombol komentar -------------------------------------------------------
                          TextButton.icon(
                            onPressed: () {
                              // jika berada di halaman home,
                              // jike tekan tombol komentar, maka akan dialihkan ke
                              // halaman post dan textfield komentar dalam mode focus,
                              if (ModalRoute.of(context)!.settings.name !=
                                  "/post") {
                                Navigator.pushNamed(
                                  context,
                                  "/post",
                                  arguments: getPost!.id,
                                );
                              }

                              // focus kan komentar
                              Provider.of<PageData>(context, listen: false)
                                  .changeKomentarFocus(true);
                            },
                            icon: const Icon(Icons.mode_comment_outlined),
                            style: Theme.of(context).textButtonTheme.style,
                            label: Text(getPost != null ? getPost!.totalKomentar.toString() : ""),
                          ),
                        ],
                      );
                    })
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> showDeleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Pemberitahuan!"),
            content: const Text("Apakah Anda yakin ingin menghapus post ini?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Batalkan"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.popAndPushNamed(context, "/");
                  Provider.of<PostData>(context, listen: false).delete(post.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Post berhasil dihapus!")));
                },
                child: const Text("Ya"),
              ),
            ],
          );
        });
  }

  Future<dynamic> showImgDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Image.network(post.img!),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Tutup"),
              ),
            ],
          );
        });
  }

    String getDifferenceTime() {
    int detik =
        post.tglDibuat.difference(DateTime.now()).inSeconds.abs();

    if (detik < 60) {
      return "$detik detik yang lalu";
    } else if (detik < 3600) {
      int menit = (detik / 60).floor();
      return "$menit menit yang lalu";
    } else if (detik < 3600 * 24) {
      int jam = (detik / 3600).floor();
      return "$jam jam yang lalu";
    } else {
      return DateFormat('dd MMM yyyy HH.mm').format(post.tglDibuat);
    }
  }
}
