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
        child: FutureBuilder<User>(
          future: Provider.of<UserData>(context, listen: false).getUser("1"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User user = snapshot.data!;
              return Text(user.username);
            }
            return Text("Gagal ambil data");
          },
        ),
      ),
    );
  }
}
