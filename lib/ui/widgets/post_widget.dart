part of "widgets.dart";

class PostWidget extends StatelessWidget {
  Post post;

  PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context, listen: false)
        .users
        .where((user) => user.id == post.userId)
        .toList()[0];

    int authUserid = Provider.of<AuthProvider>(context).authUser.id;

    // bool isLiked = Provider.of<LikeProvider>(context)
    //     .isLiked(authUserid, post.id);

    return Consumer<LikeProvider>(builder: (context, likeProvider, child) {
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
                      // IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline, ), ),
                      TextButton.icon(
                        onPressed: () {
                          if (!likeProvider.isLiked(
                            authUserid,
                            post.id,
                          )) {
                            likeProvider.addlike(
                              Like(
                                  id: Provider.of<LikeProvider>(
                                        context,
                                        listen: false,
                                      ).likeCount +
                                      1,
                                  type: "post",
                                  userId: authUserid,
                                  postId: post.id),
                            );
                          } else {
                            likeProvider.deleteLike(
                              likeProvider.likes
                                  .where((like) =>
                                      like.userId == authUserid &&
                                      like.postId == post.id)
                                  .toList()[0],
                            );
                          }
                        },
                        icon: Icon(
                          likeProvider.isLiked(authUserid, post.id)
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline,
                          color: likeProvider.isLiked(
                                  Provider.of<AuthProvider>(context)
                                      .authUser
                                      .id,
                                  post.id)
                              ? colors["soft-pink"]
                              : Theme.of(context).colorScheme.primary,
                        ),
                        style: Theme.of(context).textButtonTheme.style,
                        label: Text(
                          Provider.of<LikeProvider>(context, listen: false)
                              .getLikesNumber(postId: post.id)
                              .toString(),
                          style: TextStyle(
                              color: likeProvider.isLiked(authUserid, post.id)
                                  ? colors["soft-pink"]
                                  : Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // Navigator.pushNamed(
                          //   context,
                          //   "/post",
                          //   arguments: post,
                          // );
                          // Provider.of<PageProvider>(context, listen: false)
                          //     .changeKomentarFocus(true);
                        },
                        icon: Icon(Icons.mode_comment_outlined),
                        style: Theme.of(context).textButtonTheme.style,
                        label: Text(
                          Provider.of<KomentarProvider>(context, listen: false)
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
