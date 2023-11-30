part of "pages.dart";

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  @override
  Widget build(BuildContext context) {
    UserAcc? user;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Pengaturan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          FutureBuilder<UserAcc>(
            future: Provider.of<UserData>(context, listen: false)
                .getUser(FirebaseAuth.instance.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                user = snapshot.data!;
              }
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        user?.foto ?? "",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.username ?? "",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .fontSize,
                            ),
                          ),
                          Text(
                            user?.email ?? "",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .fontSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return EditPage();
                                  },
                                ),
                              );
                            },
                            child: Icon(
                              Icons.navigate_next_rounded,
                              size: 30,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "TAMPILAN",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                ),
              ),
              Divider(
                height: 20,
                thickness: 1,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.outline),
                        child: IconButton(
                          icon: Icon(Icons.phone_android_rounded,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 30),
                          onPressed: () {
                            Provider.of<ThemeModeData>(context, listen: false)
                                .changeTheme(ThemeMode.system);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          Provider.of<ThemeModeData>(context, listen: false)
                              .changeTheme(ThemeMode.system);
                        },
                        child: Text(
                          "Default System",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.sunny,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 30),
                          onPressed: () {
                            Provider.of<ThemeModeData>(context, listen: false)
                                .changeTheme(ThemeMode.light);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          Provider.of<ThemeModeData>(context, listen: false)
                              .changeTheme(ThemeMode.light);
                        },
                        child: Text(
                          "Light Mode",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.nightlight_round,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 30),
                          onPressed: () {
                            Provider.of<ThemeModeData>(context, listen: false)
                                .changeTheme(ThemeMode.dark);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          Provider.of<ThemeModeData>(context, listen: false)
                              .changeTheme(ThemeMode.dark);
                        },
                        child: Text(
                          "Dark Mode",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "AKUN",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                ),
              ),
              Divider(
                height: 20,
                thickness: 1,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.lock,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 30),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          String id = FirebaseAuth.instance.currentUser!.uid;
                          ubahPass(context, id);
                        },
                        child: Text(
                          "Ubah Password",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.logout_rounded,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 30),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.popAndPushNamed(context, "/sign-in");

                            // kembalikan ke home page
                            Provider.of<PageData>(context, listen: false)
                                .changeMainPage(0);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.popAndPushNamed(context, "/sign-in");
                          // kembalikan ke home page
                          Provider.of<PageData>(context, listen: false)
                              .changeMainPage(0);
                        },
                        child: Text(
                          "Keluar Akun",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.delete,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 30),
                          onPressed: () async {
                            String id = FirebaseAuth.instance.currentUser!.uid;
                            hapusDataAkun(context, id);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () async {
                          String id = FirebaseAuth.instance.currentUser!.uid;
                          hapusDataAkun(context, id);
                        },
                        child: Text(
                          "Hapus Akun",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          )
        ],
      ),
    );
  }
}

Future<void> ubahPass(BuildContext context, String id) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = firestore.collection("users");
  UserAcc? user;

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Ubah Password",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
          ),
        ),
        content: TextFormField(
            // controller: _ctrlUsername,
            // decoration: InputDecoration(
            //   border: OutlineInputBorder(),
            //   hintText: user?.username ?? "",
            // ),
            ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Batal",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              String userId = FirebaseAuth.instance.currentUser!.uid;
              //await hapusData(posts, users, userId, id);
              Navigator.pushReplacementNamed(context, "/sign-in");
            },
            child: Text(
              "Yakin",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> hapusDataAkun(BuildContext context, String id) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = firestore.collection("users");
  CollectionReference posts = firestore.collection("posts");

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Hapus Akun",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
          ),
        ),
        content: Text(
          "Yakin akan menghapus akun ?",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Batal",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              String userId = FirebaseAuth.instance.currentUser!.uid;
              await hapusData(posts, users, userId, id);
              Navigator.pushReplacementNamed(context, "/sign-in");
            },
            child: Text(
              "Yakin",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> hapusData(CollectionReference posts, CollectionReference users,
    String userId, String id) async {
  await hapusAkun(users, id);
}

Future<void> hapusAkun(CollectionReference users, String id) async {
  await users.doc(id).delete();
  await FirebaseAuth.instance.currentUser!.delete();
}

Future<void> hapusKomentar(CollectionReference posts, String userId) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference komentarsRef =
      FirebaseFirestore.instance.collection("komentars");
  QuerySnapshot komentars =
      await komentarsRef.where("userId", isEqualTo: userId).get();

  // hapus semua komentar yang mengomentari post
  komentars.docs.forEach((komentar) {
    komentarsRef.doc(komentar.id).delete();
  });
  await posts.doc(userId).delete();
}

// Future<void> hapusPost(CollectionReference posts, String userId) async {
//   String userId = FirebaseAuth.instance.currentUser!.uid;
//   CollectionReference postsRef =
//       FirebaseFirestore.instance.collection("posts");
//   QuerySnapshot posts =
//       await postsRef.where("userId", isEqualTo: userId).get();

//   // hapus semua komentar yang mengomentari post
//   posts.docs.forEach((post) {
//     postsRef.doc(post.id).delete();
//   });
//   await posts.doc(userId).delete();
// }
