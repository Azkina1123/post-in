part of "widgets.dart";

class IkutiBtn extends StatelessWidget {
  String userId;
  IkutiBtn({
    super.key,
    required this.userId
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Provider.of<UserData>(context, listen: false)
            .usersCollection
            .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserAcc authUser = UserAcc.fromJson(
                snapshot.data!.docs[0].data() as Map<String, dynamic>);
            return SizedBox(
              width: 115,
              child: authUser.followings.contains(userId)
                  ? OutlinedButton(
                      onPressed: () {
                        Provider.of<UserData>(context, listen: false)
                            .toggleIkuti(userId);
                      },
                      child: const Text("Diikuti"),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        Provider.of<UserData>(context, listen: false)
                            .toggleIkuti(userId);
                      },
                      child: const Text("Mengikuti"),
                    ),
            );
          }
          return const Text("");
        });
  }
}
