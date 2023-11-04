part of "pages.dart";

class PostPage extends StatelessWidget {
  Post post;
  PostPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    // var komentars = Provider.of<KomentarProvider>(context, listen: false)
    //     .komentars
    //     .where((komentar) => komentar.postId == post.id)
    //     .toList();

    return Consumer<KomentarProvider>(
        builder: (context, komentarProvider, child) {
      komentarProvider.sortKomentarbyDate();
      List<Komentar> komentars = komentarProvider.getKomentars(postId: post.id);

      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Post",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        body: ListView.builder(
          // physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, i) {
            return Column(
              children: [
                if (i == 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PostWidget(
                        post: post,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        child: Text(
                          "Komentar (${komentars.length})",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      InputKomentar(
                        post: post,
                      ),
                    ],
                  ),

                if (komentars.isNotEmpty)
                  Column(
                    children: [
                      Divider(
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.5),
                        indent: 10,
                        endIndent: 10,
                      ),
                      KomentarWidget(
                        komentar: komentars[i],
                      ),

                    ],
                  ),
                  
                  

                if (i == komentars.length - 1)
                  const SizedBox(
                    height: 20,
                  ),

                // else
              ],
            );
          },
          itemCount: komentars.isEmpty
              ? 1
              : komentars.length,
        ),
      );
    });
  }
}
