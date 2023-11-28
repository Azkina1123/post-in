part of "providers.dart";

// class AuthData extends ChangeNotifier {
//   // User? _authUser = User(
//   //     id: 1,
//   //     tglDibuat: DateTime.now(),
//   //     username: "alu",
//   //     namaLengkap: "Muhammad Alucard",
//   //     email: "alu.ml@gmail.com",
//   //     gender: "Laki-laki",
//   //     noTelp: "08654356711",
//   //     password: "alufeed",
//   //     foto: "https://www.ligagame.tv/images/Nana-Hero-Mobile-Legends_4f22c.jpg",
//   //     sampul:
//   //         "https://cdn0-production-images-kly.akamaized.net/nfGPmqh5WL9S0xCXZPHzQMKf_mw=/1200x675/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/1441599/original/069415500_1482288576-lenovo-a5000-phone-coc-clash-clans-account-level-141-10-max-rash-1511-21-rash_7.jpg");

//   User get authUser => _authUser!;

//   void login(User user) async {
//     _authUser = user;
//   }

//   void logout() {
//     _authUser = null;
//     notifyListeners();
//   }
// }

class Auth extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? id_now;

  Future<void> regis(String nama, String email, String username,
      String password, String gender, String nomor) async {
    // try {
    final user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    id_now = user.user!.uid;

    Userdata user_data = Userdata(
        docId: id_now,
        tglDibuat: DateTime.now(),
        username: username,
        namaLengkap: nama,
        email: email,
        noTelp: nomor,
        gender: gender,
        password: password);

    UserData().add(user_data);
  }

  Future<void> login(String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    id_now = user.user!.uid;
  }
}
