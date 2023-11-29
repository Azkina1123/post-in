part of "pages.dart";

class CariPage extends StatefulWidget {
  const CariPage({Key? key}) : super(key: key);

  @override
  _CariPageState createState() => _CariPageState();
}

class _CariPageState extends State<CariPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        scrolledUnderElevation: 0,
        title: SizedBox(
          height: 40,
          child: TextField(
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
              dividerColor: Theme.of(context)
                  .colorScheme
                  .tertiary
                  .withOpacity(0.5),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // if(_index == 0)
                  //   Center(
                  //     child: Text("Testing"),
                  //   )
                  if (_index == 0)
                    StreamBuilder<QuerySnapshot>(
                      stream: _getSnapshot(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container(
                            width: width(context),
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          final posts = snapshot.data!.docs;

                          return Column(
                            children: [
                              for (int i = 0; i < posts.length; i++)
                                Column(
                                  children: [
                                    PostWidget(
                                      post: Post.fromJson(posts[i].data()
                                          as Map<String, dynamic>),
                                    ),

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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stream<QuerySnapshot<Object?>> _getSnapshot() {
    switch (_index) {
      case 0:
        return Provider.of<PostData>(context)
            .postsCollection
            .orderBy("tglDibuat", descending: true)
            .snapshots();
      case 1:
        return Provider.of<PostData>(context)
            .postsCollection
            .orderBy("totalLike", descending: true)
            .orderBy("totalKomentar", descending: true)
            .orderBy("tglDibuat", descending: true)
            .snapshots();
      default:
        throw Exception("Indeks $_index tidak valid.");
    }
  }
}
