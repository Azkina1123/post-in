part of "pages.dart";

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _index = 0;

  @override
  Widget build(
    BuildContext context,
  ) {
    UserAcc user = ModalRoute.of(context)!.settings.arguments
        as UserAcc; // profile user yg sedang dilihat

    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                child: Image.network(
                  user.sampul!,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 150,
                left: 10,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.background,
                      width: 3,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      user.foto!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 25),
                child: Text(
                  user.username,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 5),
                child: Text(
                  user.namaLengkap,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: ElevatedButton(
                    onPressed: () {
                      user!.toggleIkuti(context);
                    },
                    child: Text("Follow")),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextButton(
                  style: Theme.of(context).textButtonTheme.style,
                  onPressed: () {
                    Navigator.pushNamed(context, '/follow');
                    // user.toggleIkuti();
                  },
                  child: Text("10" + " Followings")),
              SizedBox(
                width: 20,
              ),
              TextButton(
                  style: Theme.of(context).textButtonTheme.style,
                  onPressed: () {
                    Navigator.pushNamed(context, '/follow');
                  },
                  child: Text("10" + " Followers")),
            ]),
          ),
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: const [Tab(text: "Postingan"), Tab(text: "Komentar")],
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  labelPadding: EdgeInsets.only(left: 10, right: 10),
                  dividerColor:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                  onTap: (i) {
                    setState(() {
                      _index = i;
                    });
                  },
                ),
                TabBarView(
                  children: [
                    if (_index == 0)
                      StreamBuilder<QuerySnapshot>(
                        stream: _index == 0
                            ? Provider.of<PostData>(context)
                                .postsCollection
                                .where("userId", isEqualTo: user.id)
                                .snapshots()
                            : Provider.of<PostData>(context)
                                .postsCollection
                                .orderBy("totalLike", descending: true)
                                .orderBy("totalKomentar", descending: true)
                                .orderBy("tglDibuat", descending: true)
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
                                      // Kasih pembatas antar post --------------------------------------
                                      if (i != posts.length - 1)
                                        Divider(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary
                                              .withOpacity(0.5),
                                          indent: 10,
                                          endIndent: 10,
                                        )
                                      // Di post terakhir tidak perlu pembatas -------------------------
                                      else
                                        const SizedBox(
                                          height: 20,
                                        )
                                    ],
                                  )
                              ],
                            );
                          }
                          return const Text("Anda belum menambahkan post.");
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
