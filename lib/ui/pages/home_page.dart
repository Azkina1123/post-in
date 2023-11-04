part of "pages.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // jalankan fungsi-fungsi setelah widget selesai dibangun
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // kalau login sudah jadi, hapus
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).login(
        Provider.of<UserProvider>(
          context,
          listen: false,
        ).users[0], // user yg sedang login adalah user di index 0
      );

      // saat pertama kali running, urutkan dari yang terbaru
      // karena defaultnya tab bar berada di tab post terbaru
      Provider.of<PostProvider>(context, listen: false).sortByDateDesc();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(builder: (ctx, postProvider, child) {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          // app bar ========================================================================
          appBar: AppBar(
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
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      ctx,
                      "/profile",
                      arguments: Provider.of<AuthProvider>(ctx, listen: false)
                          .authUser,
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        Provider.of<AuthProvider>(ctx, listen: false)
                            .authUser
                            .username,
                      ),
                      SizedBox(width: 10,),
                      AccountButton(
                        onPressed: null,
                        image: Provider.of<AuthProvider>(ctx, listen: false)
                            .authUser
                            .foto!,
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // tab bar ---------------------------------------------------------------------
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
                _index = i;
                if (i == 0) {
                  postProvider.sortByDateDesc();
                } else if (i == 1) {
                  postProvider.sortByPopularityDesc();
                } else if (i == 2) {
                  print("masuk");
                  _getFollowedPost();
                }
              },
            ),
          ),

          // konten halaman ===============================================================
          body: ListView(
            children: [
              // input postingan baru ------------------------------------------------------
              InputPost(tabIndex: _index),

              // daftar postingan ----------------------------------------------------------
              Column(
                children: [
                  for (int i = 0;
                      i <
                          (_index != 2
                              ? postProvider.postCount
                              : postProvider.followedPosts.length);
                      i++)
                    Column(
                      children: [
                        PostWidget(
                            post: _index != 2
                                ? postProvider.posts[i]
                                : postProvider.followedPosts[i]),

                        // kasih pembatas antar post --------------------------------------
                        if (i !=
                            (_index != 2
                                    ? postProvider.postCount
                                    : postProvider.followedPosts.length) -
                                1)
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
              )
            ],
          ),
        ),
      );
    });
  }

  void _getFollowedPost() {
    // List
    List<Following> followedUser =
        Provider.of<FollowingProvider>(context, listen: false).getFollowed(
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).authUser.id,
    );

    // List<Post> followedPosts = [];
    for (int i = 0; i < followedUser.length; i++) {
      Provider.of<PostProvider>(context, listen: false).addFollowedPosts(followedUser[i].userId1);
    }
  }
}
