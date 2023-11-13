part of "pages.dart";

class PostPage extends StatelessWidget {
  Post post;
  PostPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Consumer<KomentarData>(builder: (context, komentarData, child) {
      // List<Komentar> komentars = komentarData.getKomentars(postId: post.id);

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
        body: ListView(
          children: [
            // POST ============================================================================
            PostWidget(
              post: post,
            ),

            StreamBuilder<QuerySnapshot>(
                stream: komentarData.komentarsRef
                    .where("postId", isEqualTo: post.id)
                    .orderBy("totalLike", descending: true)
                    .orderBy("tglDibuat", descending: true)
                    // .orderBy("tglDibuat", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: width(context),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {

                    final data = snapshot.data;
                    int komentarCount = data!.docs.length;
                  
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // KOMENTAR =======================================================================
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Text(
                            // "Komentar (${komentars.length})",
                            "Komentar ($komentarCount)",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),

                        // INPUT KOMENTAR =======================================================================

                        InputKomentar(
                          post: post,
                        ),

                        // DAFTAR KOMENTAR =======================================================================

                        for (int i = 0; i < komentarCount; i++)
                          Column(
                            children: [
                              KomentarWidget(
                                komentar: Komentar(
                                  id: data.docs[i].get("id"),
                                  idDoc: data.docs[i].id,
                                  tglDibuat:
                                      data.docs[i].get("tglDibuat").toDate(),
                                  konten: data.docs[i].get("konten"),
                                  totalLike: data.docs[i].get("totalLike"),
                                  postId: data.docs[i].get("postId"),
                                  userId: data.docs[i].get("userId"),
                                ),
                                postId: post.id,
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

                  return Text("Tidak dapat tersambung.", textAlign: TextAlign.center,);
                })
          ],
        ),
      );
    });
  }
}
