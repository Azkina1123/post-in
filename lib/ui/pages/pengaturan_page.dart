// ignore_for_file: use_build_context_synchronously

part of "pages.dart";

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

bool _isObscure = true;
UserAcc? user;
TextEditingController _ctrlOldPass = TextEditingController();
TextEditingController _ctrlNewPass = TextEditingController();

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
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: width(context),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                user = snapshot.data!;
              }
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/edit",
                        arguments: user);
                  },
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
                                    .titleMedium!
                                    .fontSize,
                              ),
                            ),
                            Text(
                              user?.email ?? "",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .fontSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Icon(
                          Icons.navigate_next_rounded,
                          size: 30,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
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
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                height: 20,
                thickness: 1,
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Provider.of<ThemeModeData>(context, listen: false)
                                          .themeMode ==
                                      ThemeMode.system
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outline,
                        ),
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
                      const SizedBox(width: 10),
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
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Provider.of<ThemeModeData>(context, listen: false)
                                          .themeMode ==
                                      ThemeMode.light
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outline,
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
                      const SizedBox(width: 10),
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
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Provider.of<ThemeModeData>(context, listen: false)
                                          .themeMode ==
                                      ThemeMode.dark
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outline,
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
                      const SizedBox(width: 10),
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
              const SizedBox(height: 20),
              Text(
                "AKUN",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                height: 20,
                thickness: 1,
              ),
              const SizedBox(height: 10),
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
                          onPressed: () {
                            String id = FirebaseAuth.instance.currentUser!.uid;
                            ubahPass(context, id);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
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
                  const SizedBox(height: 10),
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
                            Navigator.popAndPushNamed(context, "/landing");

                            // kembalikan ke home page
                            // Provider.of<PageData>(context, listen: false)
                            //     .changeMainPage(0);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.popAndPushNamed(context, "/landing");
                          // kembalikan ke home page
                          // Provider.of<PageData>(context, listen: false)
                          //     .changeMainPage(0);
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
                  const SizedBox(height: 10),
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
                      const SizedBox(width: 10),
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

  // void _validatePassword() {
  //   String enteredPassword = _ctrlOldPass.text;

  //   if (enteredPassword == snapshot.data?.password) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("Konfirmasi Password Berhasil !"),
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("Konfirmasi Password Gagal !"),
  //       ),
  //     );
  //   }

  //   Navigator.popAndPushNamed(context, "/");
  // }

  Future<void> ubahPass(BuildContext context, String id) async {
    await Provider.of<UserData>(context, listen: false)
        .getUser(FirebaseAuth.instance.currentUser!.uid);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");

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
          content: FutureBuilder(
            future: Provider.of<UserData>(context, listen: false)
                .getUser(FirebaseAuth.instance.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  width: 80,
                  height: 130,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _ctrlOldPass,
                        obscureText: _isObscure,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Password Lama",
                          labelText: "Password Lama",
                          // suffixIcon: IconButton(
                          //   icon: Icon(_isObscure
                          //       ? Icons.visibility
                          //       : Icons.visibility_off),
                          //   onPressed: () {
                          //     _isObscure = !_isObscure;
                          //   },
                          // ),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(25),
                        ],
                        // onEditingComplete: () {

                        // },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _ctrlNewPass,
                        obscureText: _isObscure,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Password Baru",
                          labelText: "Password Baru",
                          // suffixIcon: IconButton(
                          //   icon: Icon(_isObscure
                          //       ? Icons.visibility
                          //       : Icons.visibility_off),
                          //   onPressed: () {
                          //     _isObscure = !_isObscure;
                          //   },
                          // ),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(25),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const Text("Loading . . .");
              }
            },
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
                UserAcc user =
                    await Provider.of<UserData>(context, listen: false)
                        .getUser(FirebaseAuth.instance.currentUser!.uid);
                String enteredPassword = _ctrlOldPass.text;

                if (enteredPassword != user.password) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Konfirmasi Password Gagal !"),
                    ),
                  );
                  return;
                }
                
                String id = FirebaseAuth.instance.currentUser!.uid;
                await users.doc(id).update({
                  "password": _ctrlNewPass.text.toString(),
                });
                await ubahPassAuth(users, id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Ubah Password Berhasil !"),
                  ),
                );
                Navigator.of(context).pop();
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
                Provider.of<UserData>(context, listen: false).delete(userId);
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

  Future<void> ubahPassAuth(CollectionReference users, String id) async {
    await FirebaseAuth.instance.currentUser!.updatePassword(_ctrlNewPass.text);
  }
}
