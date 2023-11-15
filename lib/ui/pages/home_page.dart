part of "pages.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  List<int>? followedUserId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    // jalankan fungsi-fungsi setelah widget selesai dibangun
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      
      _getFollowedUserId();

      // kalau login sudah jadi, hapus
      // Provider.of<AuthData>(
      //   context,
      //   listen: false,
      // ).login(
      //   await Provider.of<UserData>(
      //     context,
      //     listen: false,
      //   ).getUser("1") // user yg sedang login adalah user dgn id 1
      // );

      //     Provider.of<UserData>(context, listen: false).add(
      //   User(
      //     id: 1,
      //     tglDibuat: DateTime.now(),
      //     username: "bebek",
      //     namaLengkap: "Bebek Geprek",
      //     email: "bebeik.bakar@gmail.com",
      //     password: "nyamnyam",
      //     foto:
      //         "https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2022/06/14024013/Tak-Hanya-Lezat-Ini-X-Manfaat-Bayam-bagi-Kesehatan-Tubuh-01.jpg",
      //   ),
      // );

      // saat pertama kali running, urutkan dari yang terbaru
      // karena defaultnya tab bar berada di tab post terbaru
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageData = Provider.of<PageData>(context, listen: false);
    // if (pageData.onSnackBar) {
    //   pageData.closeSnackBar();
    //   ScaffoldMessenger.of(context).clearSnackBars();
    // }
    return Consumer<PostData>(builder: (ctx, postData, child) {
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
                      arguments:
                          Provider.of<AuthData>(ctx, listen: false).authUser,
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        Provider.of<AuthData>(ctx, listen: false)
                            .authUser
                            .username,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      AccountButton(
                        onPressed: null,
                        image: NetworkImage(
                          Provider.of<AuthData>(ctx, listen: false)
                              .authUser
                              .foto,
                        ),
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
                  // postData.sortByDateDesc();
                } else if (i == 1) {
                  // postData.sortByPopularityDesc();
                } else if (i == 2) {
                  // _getFollowedUserId();
                }

                setState(() {});
              },
            ),
          ),

          // konten halaman ===============================================================
          body: ListView(
            children: [
              // input postingan baru ------------------------------------------------------
              InputPost(tabIndex: _index),

              // daftar postingan ----------------------------------------------------------
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
                      final data = snapshot.data!.docs;

                      return Column(
                        children: [
                          for (int i = 0; i < data.length; i++)
                            Column(
                              children: [
                                PostWidget(
                                    post: Post(
                                  id: data[i].get("id"),
                                  docId: data[i].id,
                                  tglDibuat: data[i].get("tglDibuat").toDate(),
                                  konten: data[i].get("konten"),
                                  img: data[i].get("img"),
                                  userId: data[i].get("userId"),
                                  totalKomentar: data[i].get("totalKomentar"),
                                  totalLike: data[i].get("totalLike"),
                                )),

                                // kasih pembatas antar post --------------------------------------
                                if (i != data.length - 1)
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
            .postsRef
            .orderBy("tglDibuat", descending: true)
            .snapshots();
      case 1:
        return Provider.of<PostData>(context)
            .postsRef
            .orderBy("totalLike", descending: true)
            .orderBy("totalKomentar", descending: true)
            .orderBy("tglDibuat", descending: true)
            .snapshots();
      default:
        return Provider.of<PostData>(context)
            .postsRef
            .where("userId", isEqualTo: followedUserId![0])
            .snapshots();
    }
  }

  void _getFollowedUserId() async {
    List<Following> followings =
        await Provider.of<FollowingData>(context, listen: false)
            .getFollowings();

    followedUserId = followings.map((following) => following.userId2).toList();
  }
}
