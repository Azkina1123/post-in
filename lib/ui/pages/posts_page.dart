part of "pages.dart";

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
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
            const Text("Username"),
            AccountButton(
              onPressed: () {
                setState(() {
                  Navigator.pushNamed(context, "/profile");
                });
              },
              image: const NetworkImage(
                "https://avatars.githubusercontent.com/azkina1123",
              ),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: "Post Terbaru",),
              Tab(text: "Post Terpopuler",),
              Tab(text: "Post Saya",)
            ],
            dividerColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),

          ),
        ),
        
        body: Column(
          children: [
            

            Expanded(
              // width: width(context),
              // height: height(context),
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, i) {
                  return Column(children: [
                    // buat postingan baru =========================================================
                    i == 0 ? const AddPost(): const SizedBox(),

                    UserPost(post: posts[i]),
                    i != posts.length - 1
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
                itemCount: posts.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
