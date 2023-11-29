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
    Future<void> uploadProfileImage(String imagePath) async {
      try {
        Reference storageReference =
            FirebaseStorage.instance.ref().child('profile_images/$id_now.jpg');
        UploadTask uploadTask = storageReference.putFile(File(imagePath));
        await uploadTask.whenComplete(() => print('Profile image uploaded'));
      } catch (e) {
        print('Error uploading profile image: $e');
      }
    }

    Future<void> uploadCoverImage(String imagePath) async {
      try {
        Reference storageReference =
            FirebaseStorage.instance.ref().child('cover_images/$id_now.jpg');
        UploadTask uploadTask = storageReference.putFile(File(imagePath));
        await uploadTask.whenComplete(() => print('Cover image uploaded'));
      } catch (e) {
        print('Error uploading cover image: $e');
      }
    }

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
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      id_now = user.user!.uid;
  }
}
