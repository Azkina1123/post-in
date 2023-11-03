part of "pages.dart";

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, postProvider, child) {
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
                  child: Row(
                    children: [
                      Text(postProvider.postCount.toString()),
                      AccountButton(
                        onPressed: () {
                          // Provider.of<PageProvider>(context, listen: false).changePage(1);
                          
                        },
                        image: const NetworkImage(
                          "https://avatars.githubusercontent.com/azkina1123",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              bottom: TabBar(
                tabs: const [
                  Tab(text: "Post Terpopuler"),
                  Tab(text: "Post Terbaru"),
                  Tab(text: "Post Saya")
                ],
                dividerColor:
                    Theme.of(context).colorScheme.tertiary.withOpacity(0.5)
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
                        if (i == 0) InputPost(provider: postProvider,) else const SizedBox(),

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
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
