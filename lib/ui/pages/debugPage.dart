part of "pages.dart";

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider.of<UserData>(context, listen: false).add(
    //     User(
    //       id: "",
    //       tglDibuat: DateTime.now(),
    //       username: "bebek",
    //       namaLengkap: "Bebek Geprek",
    //       email: "bebeik.bakar@gmail.com",
    //       password: "nyamnyam",
    //       gender: "Laki-laki",
    //       noTelp: "123445667",
    //       sampul: "",
    //       foto:
    //           "https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2022/06/14024013/Tak-Hanya-Lezat-Ini-X-Manfaat-Bayam-bagi-Kesehatan-Tubuh-01.jpg",
    //     ),
    //   );
    return Scaffold(
      body: Container(
        // color: Colors.amber,
        alignment: Alignment.center,
        child: FutureBuilder<List<String>>(
          future: Provider.of<UserData>(context, listen: false)
              .getUserFollowerIds(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<String> ids = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("DEBUG PAGE"),
                  Text(ids.length.toString()),
                  for (int i = 0; i < ids.length; i++) Text(ids[i]),
                ],
              );
            }
            return Text("Gagal ambil data");
          },
        ),
      ),
    );
  }
}
