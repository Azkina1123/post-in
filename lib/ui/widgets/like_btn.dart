part of "widgets.dart";

// class LikeBtn extends StatelessWidget {
//   String postId;
//   LikeBtn({super.key, required this.postId});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: Provider.of<PostData>(context, listen: false)
//             .postsCollection
//             .where("id", isEqualTo: postId)
//             .snapshots(),
//         builder: (context, snapshot) {
//           Post? post = !snapshot.hasData
//               ? null
//               : Post.fromJson(
//                   snapshot.data!.docs[0].data() as Map<String, dynamic>);
//           bool isLiked = post == null ? false :
//               post.likes.contains(FirebaseAuth.instance.currentUser!.uid);
//           return TextButton.icon(
//             onPressed: () {
//               Provider.of<PostData>(context, listen: false)
//                   .toggleLike(postId);
//             },
//             icon: Icon(
//               isLiked ? Icons.favorite_rounded : Icons.favorite_outline,
//               color: isLiked
//                   ? colors["soft-pink"]
//                   : Theme.of(context).colorScheme.primary,
//             ),
//             style: Theme.of(context).textButtonTheme.style,
//             label: Text(
//               (post != null ? post.totalLike : "").toString(),
//               style: TextStyle(
//                 color: isLiked
//                     ? colors["soft-pink"]
//                     : Theme.of(context).colorScheme.primary,
//               ),
//             ),
//           );
//         });
//   }
// }
