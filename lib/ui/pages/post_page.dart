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
      Provider.of<KomentarData>(context, listen: false).sortKomentarbyDateDesc();      
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

    return Consumer<KomentarData>(
        builder: (context, komentarProvider, child) {
      
      List<Komentar> komentars = komentarProvider.getKomentars(postId: widget.post.id);

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
            PostWidget(
              post: widget.post,
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
              post: widget.post,
            ),

            Column(
              children: [
                for (int i = 0; i < komentars.length; i++)
                  Column(
                    children: [
                      KomentarWidget(
                        komentar: komentars[i],
                      ),
                      if (i != komentars.length - 1)
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
            )
          ],
        ),
      );
    });
  }
}
