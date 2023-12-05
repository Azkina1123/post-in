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
  void dispose() {
    _ctrlCari.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_ctrlCari.text.isEmpty) {
    _ctrlCari.text = Provider.of<PageData>(context, listen: false).keywordCari;

    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: SizedBox(
          height: 40,
          child: TextField(
            controller: _ctrlCari,
            onSubmitted: (value) {
              setState(() {
                _ctrlCari.text = value;
                _search = true;
                Provider.of<PageData>(context, listen: false).cari(value);
                //getPostingan();
              });
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
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
            _ctrlCari.text.isEmpty && !_search
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(_index == 0
                        ? "Belum ada akun yang dicari."
                        : "Belum ada postingan yang dicari."),
                  )
                : (_index == 0 ? showAkun() : showPostingan())
          ],
        ),
      ),
    );
  }

  Widget showPostingan() {
    return Expanded(
      child: StreamBuilder(
        stream: Stream.fromFuture(Provider.of<PostData>(context, listen: false)
            .getSearchPosts(_ctrlCari.text)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: width(context),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final posts = snapshot.data!;
            return posts.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Post tidak ditemukan."),
                  )
                : ListView(
                    children: [
                      for (int i = 0; i < posts.length; i++)
                        Column(
                          children: [
                            PostWidget(post: posts[i]),
                            if (i != posts.length - 1)
                              Divider(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiary
                                    .withOpacity(0.5),
                                indent: 10,
                                endIndent: 10,
                              )
                            else
                              const SizedBox(
                                height: 20,
                              )
                          ],
                        ),
                    ],
                  );
          }
          return const Text("Loading...");
        },
      ),
    );
  }

  Widget showAkun() {
    return Expanded(
      child: StreamBuilder<List<UserAcc>>(
        stream: Stream.fromFuture(Provider.of<UserData>(context, listen: false)
            .getSearchUsers(_ctrlCari.text)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: width(context),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return users.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Akun tidak ditemukan."),
                  )
                : ListView(
                    children: [
                      for (int i = 0; i < users.length; i++)
                        Column(
                          children: [
                            AkunWidget(
                              user: users[i],
                            ),

                            // kasih pembatas antar akun --------------------------------------
                            if (i != users.length - 1)
                              Divider(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiary
                                    .withOpacity(0.5),
                                indent: 10,
                                endIndent: 10,
                              )
                            // di akun terakhir tidak perlu pembatas -------------------------
                            else
                              const SizedBox(
                                height: 20,
                              )
                          ],
                        )
                    ],
                  );
          }
          return const Text("Loading...");
        },
      ),
    );
  }
}
