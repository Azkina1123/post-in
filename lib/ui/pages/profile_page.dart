part of "pages.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    UserAcc user = ModalRoute.of(context)!.settings.arguments
        as UserAcc; // profile user yg sedang dilihat

    return Scaffold(
        appBar: AppBar(
          title: Text(user.id == FirebaseAuth.instance.currentUser!.uid
              ? "My Profile"
              : "Profile"),
        ),
        body: ListView(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: lebar,
                  height: 110,
                  child: ClipRRect(
                    child: Image.network(
                      user.sampul!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
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
                      child: Image.network(user.foto!,
                          width: 100, height: 100, fit: BoxFit.fill),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, top: 40),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.username,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .fontSize,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            user.namaLengkap,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .fontSize,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      user.id != FirebaseAuth.instance.currentUser!.uid
                          ? StreamBuilder<QuerySnapshot>(
                              stream:
                                  Provider.of<UserData>(context, listen: false)
                                      .usersCollection
                                      .where("id",
                                          isEqualTo: FirebaseAuth
                                              .instance.currentUser!.uid)
                                      .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  UserAcc authUser = UserAcc.fromJson(
                                      snapshot.data!.docs[0].data()
                                          as Map<String, dynamic>);
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: authUser.followings.contains(user.id)
                                        ? OutlinedButton(
                                            onPressed: () {
                                              Provider.of<UserData>(context,
                                                      listen: false)
                                                  .toggleIkuti(user.id);
                                            },
                                            child: const Text("Followed"),
                                          )
                                        : ElevatedButton(
                                            onPressed: () {
                                              Provider.of<UserData>(context,
                                                      listen: false)
                                                  .toggleIkuti(user.id);
                                            },
                                            child: const Text("Follow"),
                                          ),
                                  );
                                }
                                return const Text("");
                              })
                          : const Text(""),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                TextButton(
                    style: Theme.of(context).textButtonTheme.style,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/follow',
                        arguments: user.id,
                      );
                    },
                    child: Text("10" + " Followings")),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                    style: Theme.of(context).textButtonTheme.style,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/follow',
                        arguments: user.id,
                      );
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
                      fontSize:
                          Theme.of(context).textTheme.titleMedium!.fontSize,
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
                  if (_index == 0)
                    StreamBuilder<QuerySnapshot>(
                      stream: Provider.of<PostData>(context)
                          .postsCollection
                          .where("userId", isEqualTo: user.id)
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
                    )
                  else
                    StreamBuilder<QuerySnapshot>(
                        stream: Provider.of<KomentarData>(context)
                            .komentarsCollection
                            .where("userId", isEqualTo: user.id)
                            .orderBy("tglDibuat", descending: true)
                            .orderBy("totalLike", descending: true)
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
                            final komentars = snapshot.data!.docs;
                            int komentarCount = komentars.length;
                            return komentarCount == 0
                                ? Text("Belum ada Komentar")
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (int i = 0; i < komentarCount; i++)
                                        Column(
                                          children: [
                                            KomentarWidget(
                                              komentar: Komentar.fromJson(
                                                  komentars[i].data()
                                                      as Map<String, dynamic>),
                                            ),
                                            if (i != komentarCount - 1)
                                              Divider(
                                                color: Theme.of(context)
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

                          return const Text(
                            "Tidak dapat tersambung.",
                            textAlign: TextAlign.center,
                          );
                        }),
                ],
              ),
            ),
          ],
        ));
  }
}
