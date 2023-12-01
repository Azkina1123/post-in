part of "widgets.dart";

class AkunWidget extends StatelessWidget {
  UserAcc? user;
  AkunWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/profile",
          arguments: user!,
        );
      },
      splashColor: Colors.transparent,
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: Image.network(user?.foto ?? "").image,
      ),
      title: Text(user?.username ?? "",
          style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(user?.username ?? "",
          style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
