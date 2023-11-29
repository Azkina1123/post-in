part of "models.dart";

class UserAcc {
  String id;
  DateTime tglDibuat;
  String username;
  String namaLengkap;
  String email;
  String noTelp;
  String gender;
  String password;
  String? foto;
  String? sampul;

  int totalFollowing = 0;
  List<String> followings = [];

  UserAcc({
    required this.id,
    required this.tglDibuat,
    required this.username,
    required this.namaLengkap,
    required this.email,
    required this.noTelp,
    required this.gender,
    required this.password,
    this.foto,
    this.sampul,
  });

  factory UserAcc.fromJson(Map<String, dynamic> json) {
    UserAcc user = UserAcc(
      id: json["id"].toString(),
      tglDibuat: json["tglDibuat"].toDate(),
      username: json["username"],
      namaLengkap: json["namaLengkap"],
      email: json["email"],
      gender: json["gender"],
      noTelp: json["noTelp"],
      sampul: json["sampul"],
      password: json["password"],
      foto: json["foto"],
    );
    user.followings = List<String>.from(json["followings"]);

    return user;
  }

  void toggleIkuti(BuildContext context) async {
    QuerySnapshot querySnapshot =
        await Provider.of<UserData>(context, listen: false)
            .usersCollection
            .where("id", isEqualTo: id)
            .get();

    List<String> followings = List<String>.from(querySnapshot.docs[0].get("followings"));
    String authUserId = FirebaseAuth.instance.currentUser!.uid;
    if (followings.contains(authUserId)) {
      followings.remove(authUserId);
    } else {
      followings.add(authUserId);
    }

    Provider.of<UserData>(context, listen: false)
        .usersCollection
        .doc(id)
        .update({"followings": followings, "totalLike": followings.length});
  }
}
