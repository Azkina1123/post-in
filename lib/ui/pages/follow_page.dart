part of 'pages.dart';

class FollowPage extends StatefulWidget {
  const FollowPage({super.key});

  @override
  State<FollowPage> createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    String userId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<UserAcc>(
            future:
                Provider.of<UserData>(context, listen: false).getUser(userId),
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
        child: ListView(
          children: [
            TabBar(
              tabs: const [Tab(text: "Followings"), Tab(text: "Followers")],
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                fontWeight: FontWeight.bold,
              ),
              labelPadding: EdgeInsets.only(left: 10, right: 10),
              dividerColor:
                  Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
              onTap: (i) {
                setState(() {
                  _index = i;
                });
              },
            ),
            if (_index == 0)
              FutureBuilder<List<UserAcc>>(
                  future: Provider.of<UserData>(context, listen: false)
                      .getFollowings(userId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<UserAcc> users = snapshot.data!;
                      return Column(
                        children: [
                          for (int i = 0; i < users.length; i++)
                            Column(
                              children: [
                                AkunWidget(
                                  user: users[i],
                                ),

                                // kasih pembatas antar akun --------------------------------------
                                if (i != users.length - 1)
                                  Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiary
                                        .withOpacity(0.5),
                                    indent: 10,
                                    endIndent: 10,
                                  )
                                // di akun terakhir tidak perlu pembatas -------------------------
                                else
                                  const SizedBox(
                                    height: 20,
                                  )
                              ],
                            )
                        ],
                      );
                    }
                    return Text("");
                  })
            else
              FutureBuilder<List<UserAcc>>(
                  future: Provider.of<UserData>(context, listen: false)
                      .getFollowers(userId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<UserAcc> users = snapshot.data!;
                      return Column(
                        children: [
                          for (int i = 0; i < users.length; i++)
                            Column(
                              children: [
                                AkunWidget(
                                  user: users[i],
                                ),

                                // kasih pembatas antar akun --------------------------------------
                                if (i != users.length - 1)
                                  Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiary
                                        .withOpacity(0.5),
                                    indent: 10,
                                    endIndent: 10,
                                  )
                                // di akun terakhir tidak perlu pembatas -------------------------
                                else
                                  const SizedBox(
                                    height: 20,
                                  )
                              ],
                            )
                        ],
                      );
                    }
                    return Text("");
                  }),
          ],
        ),
      ),
    );
  }
}
