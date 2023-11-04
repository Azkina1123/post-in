part of "pages.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // kalau login sudah jadi, hapus
    Provider.of<AuthProvider>(context, listen: false).login(
        Provider.of<UserProvider>(context, listen: false)
            .users[0] // user yg sedang login adalah user di index 0
        );

    return Consumer<PostProvider>(builder: (context, postProvider, child) {
      postProvider.sortByDateDesc();
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            title: Text(
              "Post.In",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      "/profile",
                      arguments:
                          Provider.of<AuthProvider>(context, listen: false)
                              .authUser,
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        Provider.of<AuthProvider>(context, listen: false)
                            .authUser
                            .username,
                      ),
                      AccountButton(
                        onPressed: null,
                        image: Provider.of<AuthProvider>(context, listen: false)
                            .authUser
                            .foto!,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            bottom: TabBar(
              tabs: const [
                Tab(text: "Post Terbaru"),
                Tab(text: "Post Terpopuler"),
                Tab(text: "Post Diikuti")
              ],
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                fontWeight: FontWeight.bold,
              ),
              labelPadding: EdgeInsets.only(left: 10, right: 10),
              dividerColor:
                  Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
              onTap: (i) {
                if (i == 0) {
                  postProvider.sortByDateDesc();
                }
              },
            ),
          ),
          body: ListView.builder(
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, i) {
              return Column(children: [
                // buat postingan baru =========================================================
                if (i == 0)
                  InputPost(),

                PostWidget(post: postProvider.posts[i]),
                i != postProvider.postCount - 1
                    ? Divider(
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.5),
                        indent: 10,
                        endIndent: 10,
                      )
                    : const SizedBox(
                        height: 20,
                      )
              ]);
            },
            itemCount: Provider.of<PostProvider>(context).postCount,
          ),
        ),
      );
    });
  }
}
