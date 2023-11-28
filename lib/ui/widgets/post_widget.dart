part of "widgets.dart";

class PostWidget extends StatelessWidget {
  Post post;

  User? user;

  PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    int authUserid = Provider.of<AuthData>(context).authUser.id;

    return Consumer2<LikeData, KomentarData>(
        builder: (context, likeData, komentarData, child) {
      return Container(
        width: width(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<User>(
              future: Provider.of<UserData>(context).getUser(post.userId),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  user = snapshot.data!;
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/profile",
                        arguments: user,
                      );
                    },
                    splashColor: Colors.transparent,
                    leading: AccountButton(
                      onPressed: null,
                      image: NetworkImage(user!.foto),
                    ),
                    title: Text(user!.username,
                        style: Theme.of(context).textTheme.titleMedium),
                    subtitle: Text(
                      DateFormat('dd MMM yyyy HH.mm').format(post.tglDibuat),
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5),
                        fontSize:
                            Theme.of(context).textTheme.bodySmall!.fontSize,
                      ),
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 'delete',
                            child: const Text('Delete'),
                            onTap: () {
                              showDeleteDialog(context);
                            },
                          )
                        ];
                      },
                    ),
                  );
                }
                return Container(
                  width: width(context),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }),
            ),
            InkWell(
              onTap: ModalRoute.of(context)!.settings.name == "/"
                  ? () {
                      Navigator.pushNamed(context, "/post", arguments: post);
                    }
                  : null,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    post.img != null
                        ? Container(
                            width: width(context),
                            height: 200,
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(post.img!),
                                  fit: BoxFit.cover),
                            ),
                          )
                        : const Text(""),

                  Text(
                    post.konten,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // like dan komentar ----------------------------------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // tombol like -------------------------------------------------------
                      SizedBox(
                        width: 70,
                        child: TextButton.icon(
                          onPressed: () async {
                            post.toggleLike(context);
                          },
                          icon: Icon(
                            post.likes.contains(authUserid)
                                ? Icons.favorite_rounded
                                : Icons.favorite_outline,
                            color: post.likes.contains(authUserid)
                                ? colors["soft-pink"]
                                : Theme.of(context).colorScheme.primary,
                          ),
                          style: Theme.of(context).textButtonTheme.style,
                          label: Text(
                            post.likes.length.toString(),
                            style: TextStyle(
                              color: post.likes.contains(authUserid)
                                  ? colors["soft-pink"]
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),

                      // tombol komentar -------------------------------------------------------
                      SizedBox(
                        width: 70,
                        child: TextButton.icon(
                                  onPressed: () {
                                    // jika berada di halaman home,
                                    // jike tekan tombol komentar, maka akan dialihkan ke,
                                    // halaman post dan textfield komentar dalam mode focus,
                                    // if (ModalRoute.of(context)!.settings.name == "/" || ModalRoute.of(context)!.settings.name == "/profile") {
                                    if (ModalRoute.of(context)!.settings.name !=
                                        null) {
                                      Provider.of<PageData>(context,
                                              listen: false)
                                          .changeRoute("/post");
                                      Navigator.pushNamed(
                                        context,
                                        "/post",
                                        arguments: post,
                                      );
                                    }

                                    // focus kan komentar
                                    Provider.of<PageData>(context,
                                            listen: false)
                                        .changeKomentarFocus(true);
                                  },
                                  icon: const Icon(Icons.mode_comment_outlined),
                                  style:
                                      Theme.of(context).textButtonTheme.style,
                                  label: Text(post.komentars.length.toString()),
                                )
                              
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showDeleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Peringatan!"),
            content: const Text("Apakah Anda yakin ingin menghapus post ini?"),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Batalkan"),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.popAndPushNamed(context, "/");
                  Provider.of<PostData>(context, listen: false).delete(post.id);
                },
                child: const Text("Ya"),
              ),
            ],
          );
        });
  }
}
