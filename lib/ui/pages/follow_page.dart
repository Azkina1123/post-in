part of 'pages.dart';

class FollowPage extends StatelessWidget {
  const FollowPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserAcc? user;

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<UserAcc>(
            future: Provider.of<UserData>(context, listen: false)
                .getUser(FirebaseAuth.instance.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                user = snapshot.data!;
              }
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  user?.username ?? "",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                  ),
                ),
              );
            }),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: const [Tab(text: "Following"), Tab(text: "Followers")],
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                fontWeight: FontWeight.bold,
              ),
              labelPadding: EdgeInsets.only(left: 10, right: 10),
              dividerColor:
                  Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
