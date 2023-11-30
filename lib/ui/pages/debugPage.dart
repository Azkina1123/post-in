part of "pages.dart";

class DebugPage extends StatefulWidget {
  const DebugPage({super.key});

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  TextEditingController _con = TextEditingController();
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
          child: StreamBuilder(
            stream: Provider.of<PostData>(context, listen: false)
                .postsCollection
                .where("konten", isGreaterThanOrEqualTo: _con.text)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final posts = snapshot.data!.docs;
                return ListView(
                  children: [
                    for (int i = 0; i < posts.length; i++)
                      Text(
                          Post.fromJson(posts[i].data() as Map<String, dynamic>)
                              .konten)
                  ],
                );
              }
              return Text("Loading...");
            },
          )),
    );
  }
}
