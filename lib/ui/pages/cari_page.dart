part of "pages.dart";

class CariPage extends StatefulWidget {
  const CariPage({Key? key}) : super(key: key);

  @override
  _CariPageState createState() => _CariPageState();
}

class _CariPageState extends State<CariPage> {
  int _index = 0;
  bool _search = false;
  TextEditingController _ctrlCari = TextEditingController();
  List<Post> PostCari = [];
  List<UserAcc> UserCari = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: SizedBox(
          height: 40,
          child: TextField(
            controller: _ctrlCari,
            onSubmitted: (query) {
              setState(() {
                _ctrlCari.text = query;
                _search = true;
                //getPostingan();
              });
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Cari',
              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle!,
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              onTap: (index) {
                setState(() {
                  _index = index;
                });
              },
              tabs: const [
                Tab(text: "Akun"),
                Tab(text: "Postingan"),
              ],
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                fontWeight: FontWeight.bold,
              ),
              labelPadding: const EdgeInsets.only(left: 10, right: 10),
              indicatorColor: Theme.of(context).colorScheme.primary,
              indicatorWeight: 2,
              dividerColor:
                  Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
            ),
            Text(_ctrlCari.text),
            _ctrlCari.text.isEmpty && !_search
                ? Text(_index == 0
                    ? "Belum ada akun yang dicari."
                    : "Belum ada postingan yang dicari.")
                : (_index == 0 ? showAkun() : showPostingan())
          ],
        ),
      ),
    );
  }

  void getPostingan() async {
    QuerySnapshot postingan = await Provider.of<PostData>(context, listen: false)
        .postsCollection
        .where("konten", isEqualTo: _ctrlCari.text)
        .orderBy("tglDibuat", descending: true)
        .get();
    final posts = postingan.docs;
    posts.forEach((post) {
      PostCari.add(Post.fromJson(post.data() as Map<String, dynamic>));
    });
  }

  Widget showPostingan() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<PostData>(context, listen: false)
            .postsCollection
            .where("konten", isEqualTo: _ctrlCari.text)
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
            final posts = snapshot.data!.docs;
            // posts.forEach((post) {
            //   PostCari.add(
            //     Post.fromJson(post.data() as Map<String, dynamic>),
            //   );
            // });
            Column(
        children: [
          Text(posts[0].get("konten")),
          for (int i = 0; i < posts.length; i++)
            Column(
              children: [
                PostWidget(post: Post.fromJson(posts[i].data() as Map<String, dynamic>)),
                // Kasih pembatas antar post --------------------------------------
                if (i != posts.length - 1)
                  Divider(
                    color: Theme.of(context)
                        .colorScheme
                        .tertiary
                        .withOpacity(0.5),
                    indent: 10,
                    endIndent: 10,
                  )
                // Di post terakhir tidak perlu pembatas -------------------------
                else
                  const SizedBox(
                    height: 20,
                  )
              ],
            )
        ],
      );
          }
          return const Text("Belum ada post yang ditambahkan.");
        },
      ),
    );
  }

  Widget showAkun() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<UserData>(context, listen: false)
            .usersCollection
            .where("username", isEqualTo: _ctrlCari.text)
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
            final users = snapshot.data!.docs;
            return Text(users[0].get("username"));
          }
          return const Text("Belum ada post yang ditambahkan.");
        },
      ),
    );
  }
}
