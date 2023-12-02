part of "pages.dart";

class DebugPage extends StatefulWidget {
  const DebugPage({super.key});

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  final TextEditingController _con = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _con,
          onSubmitted: (value) {
            setState(() {
              _con.text = value;
            });
          },
        ),
      ),
      body: Container(
          // color: Colors.amber,
          alignment: Alignment.center,
          child: _con.text.isEmpty
              ? Text("Cari dulu")
              : StreamBuilder(
                  stream: Stream.fromFuture(
                      Provider.of<PostData>(context, listen: false)
                          .getSearchPosts(_con.text)),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final posts = snapshot.data!;
                      return ListView(
                        children: [
                          for (int i = 0; i < posts.length; i++)
                            PostWidget(post: posts[i])
                        ],
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                )),
    );
  }
}
