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
      body: //Center(child: Text(user.username)),
          ListView(
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                //backgroundImage: Image.file(user.foto).image,
              ),
              Text(user.username),
            ],
          ),
        ],
      ),
    );
  }
}
