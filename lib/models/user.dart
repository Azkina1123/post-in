part of "models.dart";

class UserAcc {
  String id;
  DateTime tglDibuat;
  String username;
  String namaLengkap;
  String email;
  String noTelp;
  String gender;
  // String password;
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
    // required this.password,
    this.foto,
    this.sampul,
    String? profileImageUrl,
    String? coverImageUrl,
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
      // password: json["password"],
      foto: json["foto"],
    );
    user.followings = List<String>.from(json["followings"]);
    user.totalFollowing = user.followings.length;

    return user;
  }

//   void toggleIkuti(BuildContext context, String userId) async {
// String authUserId = FirebaseAuth.instance.currentUser!.uid;
//     QuerySnapshot querySnapshot =
//         await Provider.of<UserData>(context, listen:false).usersCollection.where("id", isEqualTo: authUserId).get();

//     List<String> followings =
//         List<String>.from(querySnapshot.docs[0].get("followings"));
//     if (followings.contains(id)) {
//       followings.remove(id);
//     } else {
//       followings.add(id);
//     }

//     Provider.of<UserData>(context, listen:false).usersCollection
//         .doc(authUserId)
//         .update({"followings": followings, "totalLike": followings.length});
//   }
}
