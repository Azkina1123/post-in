part of "pages.dart";

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<String> _followedUserIds = [];

  @override
  Widget build(BuildContext context) {
    getFollowedUserIds(context);

    return Consumer<PostData>(builder: (ctx, postData, child) {
      return DefaultTabController(
        initialIndex: Provider.of<PageData>(context).homeTabIndex,
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
                              arguments: authUser,
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
                Tab(text: "Post Diikuti"),
              ],
              labelStyle: TextStyle(
                color: Theme.of(ctx).colorScheme.primary,
                fontSize: Theme.of(ctx).textTheme.titleMedium!.fontSize,
                fontWeight: FontWeight.bold,
              ),
              labelPadding: EdgeInsets.only(left: 10, right: 10),
              dividerColor: Theme.of(ctx).colorScheme.tertiary.withOpacity(0.5),
              onTap: (i) {
                Provider.of<PageData>(context, listen: false).changeHomeTab(i);
              },
            ),
          ),

          // konten halaman ===============================================================
          body: RefreshIndicator(
            onRefresh: () async {
              Provider.of<PageData>(context, listen: false).refreshPage();
            },
            child: ListView(
              children: [
                // tab bar ---------------------------------------------------------------------

                // input postingan baru ------------------------------------------------------
                InputPost(),

                // daftar postingan ----------------------------------------------------------
                FutureBuilder<QuerySnapshot>(
                    future: _getSnapshot(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          width: width(context),
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        final posts = snapshot.data!.docs;

                        return posts.isEmpty
                            ? Container(
                                height: height(context) / 2,
                                alignment: Alignment.center,
                                child: const Text(
                                    "Belum ada post yang ditambahkan."),
                              )
                            : Column(
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
                      return const Text("Tidak dapat mengambil data.");
                    })
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<QuerySnapshot<Object?>> _getSnapshot(BuildContext context) {
    switch (Provider.of<PageData>(context).homeTabIndex) {
      case 0:
        return Provider.of<PostData>(context)
            .postsCollection
            .orderBy("tglDibuat", descending: true)
            .get();
      case 1:
        return Provider.of<PostData>(context)
            .postsCollection
            .orderBy("totalLike", descending: true)
            .orderBy("totalKomentar", descending: true)
            .orderBy("tglDibuat", descending: true)
            .get();

      default:
        return Provider.of<PostData>(context)
            .postsCollection
            .where("userId",
                whereIn: _followedUserIds.isNotEmpty
                    ? _followedUserIds.toList()
                    : [-1])
            .get();
    }
  }

  void getFollowedUserIds(BuildContext context) async {
    UserAcc authUser = await Provider.of<UserData>(context)
        .getUser(FirebaseAuth.instance.currentUser!.uid);
    _followedUserIds = authUser.followings;
  }
}
