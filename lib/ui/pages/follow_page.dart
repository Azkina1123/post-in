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
    // UserAcc? user;

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
        child: Column(
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
                      .getFollowings(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<UserAcc> users = snapshot.data!;
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/profile",
                            arguments: user!,
                          );
                        },
                        child: Column(
                          children: [
                            for (int i = 0; i < users.length; i++)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 10),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          Image.network(users[i].foto ?? "")
                                              .image,
                                    ),
                                    SizedBox(width: 15),
                                    Column(
                                      children: [
                                        Text(
                                          users[i].username ?? "",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .fontSize,
                                          ),
                                        ),
                                        Text(
                                          users[i].namaLengkap ?? "",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .fontSize,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    PopupMenuButton(itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          value: 'delete',
                                          child: const Text('Delete'),
                                          onTap: () {},
                                        )
                                      ];
                                    }),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    }
                    return Text("");
                  })
            else
              FutureBuilder<List<UserAcc>>(
                  future: Provider.of<UserData>(context, listen: false)
                      .getFollowers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<UserAcc> users = snapshot.data!;
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/profile",
                            arguments: user!,
                          );
                        },
                        child: Column(
                          children: [
                            for (int i = 0; i < users.length; i++)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 10),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          Image.network(users[i].foto ?? "")
                                              .image,
                                    ),
                                    SizedBox(width: 15),
                                    Column(
                                      children: [
                                        Text(
                                          users[i].username ?? "",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .fontSize,
                                          ),
                                        ),
                                        Text(
                                          users[i].namaLengkap ?? "",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .fontSize,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    PopupMenuButton(itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          value: 'delete',
                                          child: const Text('Delete'),
                                          onTap: () {},
                                        )
                                      ];
                                    }),
                                  ],
                                ),
                              ),
                          ],
                        ),
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
