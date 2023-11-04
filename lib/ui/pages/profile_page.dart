part of "pages.dart";

class ProfilePage extends StatelessWidget {
  User user; // profile user yg sedang dilihat

  ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hmmm"),
      ),
      body: Center(child: Text(user.username)),
    );
  }
}
