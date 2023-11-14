part of "pages.dart";

class ProfilePage extends StatelessWidget {
  User user; // profile user yg sedang dilihat

  ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My profile"),
      ),
      body: ListView(
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(left: 20),
                child: Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.username),
                      SizedBox(
                        width: 20,
                      ),
                      Text(user.username),
                    ],
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: Image.network(user.foto).image,
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20),
              //   child: Text(
              //     user.username,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20),
              //   child: Text(user.namaLengkap),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(children: [
                  Text(user.username + " Follower"),
                  SizedBox(
                    width: 20,
                  ),
                  Text(user.username + " Following"),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
