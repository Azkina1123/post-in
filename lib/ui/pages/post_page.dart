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

            // KOMENTAR =======================================================================
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Text(
                // "Komentar (${komentars.length})",
                "999",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            // INPUT KOMENTAR =======================================================================

            InputKomentar(
              post: widget.post,
            ),

            // DAFTAR KOMENTAR =======================================================================

            StreamBuilder<QuerySnapshot>(
                stream: komentarData.komentars.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: width(context),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    // return Column(
                    //   children: snapshot.data!.docs.map((e) =>
                    //     Column(
                    //       children: [
                    //         KomentarWidget(
                    //           komentar: Komentar(
                    //               id: e.get("id"),
                    //               tglDibuat: e.get("tglDibuat"),
                    //               konten: e.get("konten"),
                    //               postId: e.get("postId"),
                    //               userId: e.get("userId"),
                    //               ),
                    //         ),

                    //       ],
                    //     )
                    //   ).toList(),
                    // );

                    return Column(
                      children: [
                        for (int i = 0; i < snapshot.data!.docs.length; i++)
                          Column(
                            children: [
                              KomentarWidget(
                                komentar: Komentar(
                                  id: snapshot.data!.docs[i].get("id"),
                                  tglDibuat: snapshot.data!.docs[i]
                                      .get("tglDibuat")
                                      .toDate(),
                                  konten: snapshot.data!.docs[i].get("konten"),
                                  postId: snapshot.data!.docs[i].get("postId"),
                                  userId: snapshot.data!.docs[i].get("userId"),
                                ),
                              ),
                              if (i != snapshot.data!.docs.length - 1)
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
                    // return Column(
                    //   children: [
                    //     for (int i = 0; i < komentars.length; i++)
                    // Column(
                    //   children: [
                    //     KomentarWidget(
                    //       komentar: komentars[i],
                    //     ),
                    //     if (i != komentars.length - 1)
                    //       Divider(
                    //         color: Theme.of(context)
                    //             .colorScheme
                    //             .tertiary
                    //             .withOpacity(0.5),
                    //         indent: 10,
                    //         endIndent: 10,
                    //       )
                    //     // di post terakhir tidak perlu pembatas -------------------------
                    //     else
                    //       const SizedBox(
                    //         height: 20,
                    //       )
                    //   ],
                    // )
                    //   ],
                    // );
                  }
                  return Text("Belum ada komentar yang ditambahkan.");
                })
          ],
        ),
      );
    });
  }
}
