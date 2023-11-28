part of "providers.dart";

class AuthData extends ChangeNotifier {
  // UserAcc? _authUser;

  // UserAcc get authUser => _authUser!;

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

    UserAcc userData = UserAcc(
        id: id_now.toString(),
        tglDibuat: DateTime.now(),
        username: username,
        namaLengkap: nama,
        email: email,
        noTelp: nomor,
        gender: gender,
        password: password);

    UserData().add(userData);
  }

  Future<void> login(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      id_now = user.user!.uid;

      // _authUser = await UserData().getUser(id_now!);
    } catch (e) {
      print("Gagal login.");
    }
  }
}
