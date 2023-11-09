part of "widgets.dart";

class PostWidget extends StatelessWidget {
  Post post;

  PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserData>(context, listen: false)
        .users
        .where((user) => user.id == post.userId)
        .toList()[0];

    int authUserid = Provider.of<AuthData>(context).authUser.id;

    // bool isLiked = Provider.of<LikeData>(context)
    //     .isLiked(authUserid, post.id);

    return Consumer<LikeData>(builder: (context, likeProvider, child) {
      return Column(
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
              image: user.foto!,
            ),
            title: Text(user.username,
                style: Theme.of(context).textTheme.titleMedium),
            subtitle: Text(
              DateFormat('dd MMM yyyy HH.mm').format(post.tglDibuat),
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/post", arguments: post);
            },
            child: Padding(
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
                                image: post.img!, fit: BoxFit.cover),
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
                      TextButton.icon(
                        onPressed: () {
                          if (!likeProvider.isLiked(
                            authUserid,
                            postId: post.id,
                          )) {
                            likeProvider.addlike(
                              Like(
                                id: likeProvider.likesCount + 1,
                                userId: authUserid,
                                postId: post.id,
                              ),
                            );
                            Provider.of<PostData>(context, listen: false)
                                .like(post);
                          } else {
                            likeProvider.deleteLike(
                              likeProvider.likes
                                  .where((like) =>
                                      like.userId == authUserid &&
                                      like.postId == post.id)
                                  .toList()[0],
                            );
                            Provider.of<PostData>(context, listen: false)
                                .unlike(post);
                          }
                        },
                        icon: Icon(
                          likeProvider.isLiked(authUserid, postId: post.id)
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline,
                          color: likeProvider.isLiked(
                            authUserid,
                            postId: post.id,
                          )
                              ? colors["soft-pink"]
                              : Theme.of(context).colorScheme.primary,
                        ),
                        style: Theme.of(context).textButtonTheme.style,
                        label: Text(
                          Provider.of<LikeData>(context, listen: false)
                              .getLikesNumber(postId: post.id)
                              .toString(),
                          style: TextStyle(
                            color: likeProvider.isLiked(
                              authUserid,
                              postId: post.id,
                            )
                                ? colors["soft-pink"]
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),

                      // tombol komentar -------------------------------------------------------

                      TextButton.icon(
                        onPressed: () {
                          print(ModalRoute.of(context)!.settings.name);
                          // jika berada di halaman home,
                          // jike tekan tombol komentar, maka akan dialihkan ke,
                          // halaman post dan textfield komentar dalam mode focus,
                          // if (ModalRoute.of(context)!.settings.name == "/" || ModalRoute.of(context)!.settings.name == "/profile") {
                          if (ModalRoute.of(context)!.settings.name != null) {
                            Provider.of<PageData>(context, listen: false)
                                .changeRoute("/post");
                            Navigator.pushNamed(
                              context,
                              "/post",
                              arguments: post,
                            );
                          }

                          // focus kan komentar
                          Provider.of<PageData>(context, listen: false)
                              .changeKomentarFocus(true);
                        },
                        icon: Icon(Icons.mode_comment_outlined),
                        style: Theme.of(context).textButtonTheme.style,
                        label: Text(
                          Provider.of<KomentarData>(context, listen: false)
                              .getKomentarsNumber(postId: post.id)
                              .toString(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
