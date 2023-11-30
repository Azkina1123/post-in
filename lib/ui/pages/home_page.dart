part of "pages.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  List<String> _followedUserIds = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<PostData>(builder: (ctx, postData, child) {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          // app bar ========================================================================
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: null,
            scrolledUnderElevation: 0,

            // judul post.in ---------------------------------------------------------------
            title: Text(
              "Post.In",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(ctx).colorScheme.primary,
              ),
            ),

            // username & foto profile -----------------------------------------------------
            actions: [
              FutureBuilder<UserAcc>(
                  future: Provider.of<UserData>(context, listen: false)
                      .getUser(FirebaseAuth.instance.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      UserAcc authUser = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              ctx,
                              "/profile",
                              arguments: authUser.id,
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                authUser.username,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              AccountButton(
                                onPressed: null,
                                image: NetworkImage(
                                  authUser.foto ?? "",
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Text("");
                  }),
            ],
            bottom: TabBar(
              tabs: const [
                Tab(text: "Post Terbaru"),
                Tab(text: "Post Terpopuler"),
                Tab(text: "Post Diikuti")
              ],
              labelStyle: TextStyle(
                color: Theme.of(ctx).colorScheme.primary,
                fontSize: Theme.of(ctx).textTheme.titleMedium!.fontSize,
                fontWeight: FontWeight.bold,
              ),
              labelPadding: EdgeInsets.only(left: 10, right: 10),
              dividerColor: Theme.of(ctx).colorScheme.tertiary.withOpacity(0.5),
              onTap: (i) {
                setState(() {
                  _index = i;
                  // if (i == 2) getFollowedUserIds();
                });
              },
            ),
          ),

          // konten halaman ===============================================================
          body: ListView(
            children: [
              // tab bar ---------------------------------------------------------------------

              // input postingan baru ------------------------------------------------------
              InputPost(tabIndex: _index),

              // daftar postingan ----------------------------------------------------------
              if (_index == 2 && _followedUserIds.isEmpty)
                Container(
                  child: const Text("Anda belum mengikuti user mana pun."),
                  height: height(context) / 2,
                  alignment: Alignment.center,
                )
              else
                StreamBuilder<QuerySnapshot>(
                    stream: _getSnapshot(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: width(context),
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        final posts = snapshot.data!.docs;

                        return Column(
                          children: [
                            for (int i = 0; i < posts.length; i++)
                              Column(
                                children: [
                                  PostWidget(
                                    post: Post.fromJson(posts[i].data()
                                        as Map<String, dynamic>),
                                  ),

                                  // kasih pembatas antar post --------------------------------------
                                  if (i != posts.length - 1)
                                    Divider(
                                      color: Theme.of(ctx)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.5),
                                      indent: 10,
                                      endIndent: 10,
                                    )
                                  // di post terakhir tidak perlu pembatas -------------------------
                                  else
                                    const SizedBox(
                                      height: 20,
                                    )
                                ],
                              )
                          ],
                        );
                      }

                      return const Text("Belum ada post yang ditambahkan.");
                    })
            ],
          ),
        ),
      );
    });
  }

  Stream<QuerySnapshot<Object?>> _getSnapshot() {
    switch (_index) {
      case 0:
        return Provider.of<PostData>(context)
            .postsCollection
            .orderBy("tglDibuat", descending: true)
            .snapshots();
      case 1:
        return Provider.of<PostData>(context)
            .postsCollection
            .orderBy("totalLike", descending: true)
            .orderBy("totalKomentar", descending: true)
            .orderBy("tglDibuat", descending: true)
            .snapshots();

      // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      // REVISI NANTII!!
      default:
        getFollowedUserIds();
        return Provider.of<PostData>(context)
            .postsCollection
            .where("userId", whereIn: _followedUserIds.toList())
            .snapshots();
    }
  }

  void getFollowedUserIds() async {
    UserAcc authUser = await Provider.of<UserData>(context, listen: false)
        .getUser(FirebaseAuth.instance.currentUser!.uid);

    _followedUserIds = authUser.followings;
    print(_followedUserIds.length);
  }
}
