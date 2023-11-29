part of "pages.dart";

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  @override
  Widget build(BuildContext context) {
    final themeModeData = Provider.of<ThemeModeData>(context);

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
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Username"),
                      Text("Email"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 95, top: 40),
                  child: Row(
                    children: [
                      Icon(
                        Icons.navigate_next_rounded,
                        size: 30,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                        onPressed: () {},
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignIn();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.popAndPushNamed(context, "sign-in");
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
                            AuthData authData = AuthData();
                            // Hapus ID User saat ini pada firestore
                            String id = FirebaseAuth.instance.currentUser!.uid;

                            // Hapus ID User saat ini pada autentikasi
                            await FirebaseAuth.instance.currentUser!.delete();
                            hapusData(context, id);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () async {
                          AuthData authData = AuthData();
                          // Hapus ID User saat ini pada firestore
                          String id = FirebaseAuth.instance.currentUser!.uid;

                          // Hapus ID User saat ini pada autentikasi
                          await FirebaseAuth.instance.currentUser!.delete();
                          hapusData(context, id);
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

Future<dynamic> hapusData(BuildContext context, String id) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = firestore.collection("users");
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Hapus Data"),
        content: Text("Anda yakin ingin menghapus data ini ?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await hapusAkun(users, id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignIn();
                  },
                ),
              );
            },
            child: Text("Yes"),
          ),
        ],
      );
    },
  );
}

Future<void> hapusAkun(CollectionReference users, String id) async {
  await users.doc(id).delete();
}
