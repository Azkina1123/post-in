part of "widgets.dart";

class PostWidget extends StatelessWidget {
  Post post;

  String? postIdDoc;
  PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthData>(context).authUser;

    int authUserid = Provider.of<AuthData>(context).authUser.id;

    return Consumer3<PostData, LikeData, KomentarData>(
        builder: (context, postData, likeData, komentarData, child) {
      return Container(
        width: width(context),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/post", arguments: post);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
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
                  image: NetworkImage(user.foto),
                ),
                title: Text(user.username,
                    style: Theme.of(context).textTheme.titleMedium),
                subtitle: Text(
                  DateFormat('dd MMM yyyy HH.mm').format(post.tglDibuat),
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.5),
                    fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                  ),
                ),
              ),
              
              StreamBuilder(
                stream: postData.posts
                .where("id", isEqualTo: post.id)
                .snapshots(), 
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                  postIdDoc = snapshot.data!.docs.map((e) => e.id).toList()[0];

                  }
                  return const Text("");
                },
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    post.img != null
                        ? Container(
                            width: width(context),
                            height: 200,
                            margin: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(post.img!),
                                  fit: BoxFit.cover),
                            ),
                          )
                        : SizedBox(),

                    Text(
                      post.konten,
                    ),

                    // like dan komentar ----------------------------------------------------------

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // tombol like -------------------------------------------------------
                        SizedBox(
                          width: 70,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: likeData.likes
                                  .where("postId", isEqualTo: post.id)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    width: width(context),
                                    alignment: Alignment.center,
                                    child: const CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasData) {
                                  final likes = snapshot.data!;

                                  bool isLiked = likes.docs
                                      .where((like) =>
                                          like.get("userId") == user.id &&
                                          like.get("postId") == post.id)
                                      .isNotEmpty;

                                  int likeCount = likes.docs.length;

                                  return TextButton.icon(
                                    onPressed: () async {
                                      if (!isLiked) {
                                        likeData.addlike(
                                          Like(
                                            id: 1,
                                            userId: authUserid,
                                            postId: post.id,
                                          ),
                                        );

                                        postData.updateLikePost(postIdDoc!, likeCount + 1);
                                      } else {
                                        String id = likes.docs
                                            .map((e) => e.id)
                                            .toList()[0];
                                        likeData.deleteLike(id);
                                        postData.updateLikePost(postIdDoc!, likeCount - 1);
                                      }
                                    },
                                    icon: Icon(
                                      isLiked
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_outline,
                                      color: isLiked
                                          ? colors["soft-pink"]
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                    ),
                                    style:
                                        Theme.of(context).textButtonTheme.style,
                                    label: Text(
                                      likeCount.toString(),
                                      style: TextStyle(
                                        color: isLiked
                                            ? colors["soft-pink"]
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
                                      ),
                                    ),
                                  );
                                        
                                }
                                return const Text("");
                              }),
                        ),

                        // tombol komentar -------------------------------------------------------
                        SizedBox(
                          width: 70,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: komentarData.komentars
                                  .where("postId", isEqualTo: post.id)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // return Container(
                                  //   width: width(context),
                                  //   alignment: Alignment.center,
                                  //   child: const CircularProgressIndicator(),
                                  // );
                                } else if (snapshot.hasData) {
                                  final komentarCount = snapshot.data!.size;
                                  return TextButton.icon(
                                    onPressed: () {
                                      // jika berada di halaman home,
                                      // jike tekan tombol komentar, maka akan dialihkan ke,
                                      // halaman post dan textfield komentar dalam mode focus,
                                      // if (ModalRoute.of(context)!.settings.name == "/" || ModalRoute.of(context)!.settings.name == "/profile") {
                                      if (ModalRoute.of(context)!
                                              .settings
                                              .name !=
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
                                    icon: Icon(Icons.mode_comment_outlined),
                                    style:
                                        Theme.of(context).textButtonTheme.style,
                                    label: Text(komentarCount.toString()),
                                  );
                                }
                                return const Text("");
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
