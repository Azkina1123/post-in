part of "pages.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _index = 0;
  UserAcc? _user;

  @override
  Widget build(BuildContext context) {
    _clearSelectedKomentar(context);

    var lebar = MediaQuery.of(context).size.width;
    _user = ModalRoute.of(context)!.settings.arguments as UserAcc;

    return Scaffold(
        appBar: AppBar(
          title: Text(_user!.id == FirebaseAuth.instance.currentUser!.uid
              ? "My Profile"
              : "Profile"),
          leading: IconButton(
            onPressed: () {
              _clearSelectedKomentar(context);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            _clearSelectedKomentar(context);
            return true;
          },
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: ListView(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                      onTap: () => showImgDialog(context, _user!.sampul!),
                      child: Container(
                        width: lebar,
                        height: 110,
                        child: ClipRRect(
                          child: Image.network(
                            _user!.sampul!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 10,
                      child: InkWell(
                        onTap: () => showImgDialog(context, _user!.foto!),
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
                            child: Image.network(_user!.foto!,
                                width: 100, height: 100, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 20, top: 45, right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _user!.username,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .fontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "(${_user!.namaLengkap})",
                                style: TextStyle(
                                  color: colors["old-lavender"],
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .fontSize,
                                ),
                              ),
                            ],
                          ),
                          _user!.id != FirebaseAuth.instance.currentUser!.uid
                              ? IkutiBtn(userId: _user!.id)
                              : const Text(""),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          style: Theme.of(context).textButtonTheme.style,
                          onPressed: () {
                            Provider.of<PageData>(context, listen: false)
                                .changeFollowTab(0);
                            Navigator.pushNamed(
                              context,
                              '/follow',
                              arguments: _user!.id,
                            );
                          },
                          child: FutureBuilder<int>(
                            future:
                                Provider.of<UserData>(context, listen: false)
                                    .getFollowingsCount(_user!.id),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else {
                                int followingsCount = snapshot.data ?? 0;
                                return Text("$followingsCount Diikuti");
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextButton(
                          style: Theme.of(context).textButtonTheme.style,
                          onPressed: () {
                            Provider.of<PageData>(context, listen: false)
                                .changeFollowTab(1);
                            Navigator.pushNamed(
                              context,
                              '/follow',
                              arguments: _user!.id,
                            );
                          },
                          child: FutureBuilder<int>(
                            future:
                                Provider.of<UserData>(context, listen: false)
                                    .getFollowersCount(_user!.id),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else {
                                int followersCount = snapshot.data ?? 0;
                                return Text("$followersCount Pengikut");
                              }
                            },
                          ),
                        ),
                      ]),
                ),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        tabs: const [
                          Tab(text: "Postingan"),
                          Tab(text: "Komentar")
                        ],
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        labelPadding:
                            const EdgeInsets.only(left: 10, right: 10),
                        dividerColor: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.5),
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
                              .where("userId", isEqualTo: _user!.id)
                              .orderBy("tglDibuat", descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                width: width(context),
                                padding: const EdgeInsets.all(20),
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasData) {
                              final posts = snapshot.data!.docs;

                              return posts.isEmpty
                                  ? const Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Text(
                                          "Belum ada post yang ditambahkan."))
                                  : Column(
                                      children: [
                                        for (int i = 0; i < posts.length; i++)
                                          Column(
                                            children: [
                                              PostWidget(
                                                post: Post.fromJson(posts[i]
                                                        .data()
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
                            return Container(
                              width: width(context),
                              padding: const EdgeInsets.all(20),
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            );
                          },
                        )
                      else
                        StreamBuilder<QuerySnapshot>(
                            stream: Provider.of<KomentarData>(context)
                                .komentarsCollection
                                .where("userId", isEqualTo: _user!.id)
                                .orderBy("tglDibuat", descending: true)
                                .orderBy("totalLike", descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                Container(
                                  width: width(context),
                                  padding: const EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData) {
                                final komentars = snapshot.data!.docs;
                                int komentarCount = komentars.length;
                                return komentars.isEmpty
                                    ? const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Text(
                                            "Belum ada komentar yang ditambahkan."))
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (int i = 0;
                                              i < komentarCount;
                                              i++)
                                            Column(
                                              children: [
                                                KomentarWidget(
                                                  komentar: Komentar.fromJson(
                                                      komentars[i].data()
                                                          as Map<String,
                                                              dynamic>),
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

                              return Container(
                                width: width(context),
                                padding: const EdgeInsets.all(20),
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(),
                              );
                            }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<dynamic> showImgDialog(BuildContext context, String img) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Image.network(img),
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

  void _clearSelectedKomentar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    Provider.of<KomentarData>(context, listen: false).resetSelectedKomentar();
  }
}
