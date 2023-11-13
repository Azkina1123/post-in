part of "pages.dart";

class PostPage extends StatefulWidget {
  Post post;
  PostPage({super.key, required this.post});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    super.initState();

    // jalankan fungsi-fungsi setelah widget selesai dibangun
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // saat pertama kali running, urutkan dari yang terbaru
      // karena defaultnya tab bar berada di tab post terbaru
      // Provider.of<KomentarData>(context, listen: false).sortKomentarbyDateDesc();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   if (_isIn)
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<KomentarData>(builder: (context, komentarData, child) {
      // List<Komentar> komentars = komentarData.getKomentars(postId: widget.post.id);

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
              post: widget.post,
            ),

            StreamBuilder<QuerySnapshot>(
                stream: komentarData.komentars
                    .where("postId", isEqualTo: widget.post.id)
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
                          post: widget.post,
                        ),

                        // DAFTAR KOMENTAR =======================================================================

                        for (int i = 0; i < komentarCount; i++)
                          Column(
                            children: [
                              KomentarWidget(
                                komentar: Komentar(
                                  id: data.docs[i].get("id"),
                                  tglDibuat:
                                      data.docs[i].get("tglDibuat").toDate(),
                                  konten: data.docs[i].get("konten"),
                                  postId: data.docs[i].get("postId"),
                                  userId: data.docs[i].get("userId"),
                                ),
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
