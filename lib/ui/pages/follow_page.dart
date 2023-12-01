part of 'pages.dart';

class FollowPage extends StatefulWidget {
  const FollowPage({super.key});

  @override
  State<FollowPage> createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    String userId = ModalRoute.of(context)!.settings.arguments as String;
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
              tabs: const [Tab(text: "Followings"), Tab(text: "Followers")],
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                fontWeight: FontWeight.bold,
              ),
              labelPadding: EdgeInsets.only(left: 10, right: 10),
              dividerColor:
                  Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
            ),
            FutureBuilder<QuerySnapshot>(
                future: Provider.of<UserData>(context, listen: false)
                    .usersCollection
                    .where("id", whereIn: user!.followings)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<UserAcc> users = snapshot.data!.docs
                        .map((e) =>
                            UserAcc.fromJson(e.data() as Map<String, dynamic>))
                        .toList();
                    // Future<List<UserAcc>> users = Provider.of<UserData>(context, listen: false ).getUsers();
                    return Column(
                      children: [
                        for (int i = 0; i < users.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      Image.network(users[i].foto ?? "").image,
                                ),
                                SizedBox(width: 15),
                                Column(
                                  children: [
                                    Text(
                                      user?.username ?? "",
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
                                      user?.namaLengkap ?? "",
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
