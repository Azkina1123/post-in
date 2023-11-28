part of "pages.dart";

class PostPage extends StatelessWidget {
  PostPage({super.key});

  List<String> _selectedKomentar = [];

  @override
  Widget build(BuildContext context) {
    Post post = ModalRoute.of(context)!.settings.arguments as Post;
    return Consumer<KomentarData>(builder: (context, komentarData, child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              komentarData.resetSelectedKomentar();
              ScaffoldMessenger.of(context).clearSnackBars();
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "Post",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        body: ListView(
          children: [
            // POST ============================================================================
            StreamBuilder<QuerySnapshot>(
                stream: Provider.of<PostData>(context, listen: false)
                    .postsCollection
                    .where("id", isEqualTo: post.id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final posts = snapshot.data!.docs;
                    return PostWidget(
                      post: Post.fromJson(
                          posts[0].data() as Map<String, dynamic>),
                    );
                  }
                  return Container(
                    width: width(context),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                }),

            // KOMENTAR =======================================================================
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Text(
                // "Komentar (${komentars.length})",
                "Komentar (${post.komentars.length})",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            // INPUT KOMENTAR =======================================================================
            InputKomentar(
              post: post,
            ),
            // DAFTAR KOMENTAR =======================================================================

            StreamBuilder<QuerySnapshot>(
                stream: komentarData.komentarsCollection
                    .where("postId", isEqualTo: post.id)
                    .orderBy("tglDibuat", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: width(context),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    final komentars = snapshot.data!.docs;
                    int komentarCount = komentars.length;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < komentarCount; i++)
                          Column(
                            children: [
                              KomentarWidget(
                                komentar: Komentar.fromJson(komentars[i].data()
                                    as Map<String, dynamic>),
                                postId: post.id!,
                                // selected: komentarData.selectedKomentar
                                //         .contains(komentars[i].id)
                                //     ? true
                                //     : false,
                              ),
                              if (i != komentarCount - 1)
                                Divider(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiary
                                      .withOpacity(0.5),
                                  indent: 10,
                                  endIndent: 10,
                                )
                              // di post terakhir tidak perlu pembatas -------------------------
                              else
                                const SizedBox(
                                  height: 20,
                                )
                            ],
                          )
                      ],
                    );
                  }

                  return Text(
                    "Tidak dapat tersambung.",
                    textAlign: TextAlign.center,
                  );
                })
          ],
        ),
      );
    });
  }
}
