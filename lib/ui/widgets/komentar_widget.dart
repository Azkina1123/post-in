part of "widgets.dart";

class KomentarWidget extends StatelessWidget {
  Komentar komentar;
  KomentarWidget({super.key, required this.komentar});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context, listen: false)
        .users
        .where((user) => user.id == komentar.userId)
        .toList()[0];

    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 80,
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 15, right: 10),
            child: Column(
              children: [
                AccountButton(
                  onPressed: null,
                  image: user.foto!,
                ),
              ],
            ),
          ),
          Container(
            width: width(context) - 80 - 50,
            // padding: EdgeInsets.only(right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user.username ,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text( " • " +
                      DateFormat('dd MMM yyyy HH.mm').format(komentar.tglDibuat),
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodySmall!.fontSize,
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.5)),
                    ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(
                    //     Icons.favorite_border_outlined,
                    //     size: Theme.of(context).textTheme.titleMedium!.fontSize,
                    //   ),
                    //   padding: EdgeInsets.zero,
                    // ),
                  ],
                ),
                Text(
                  komentar.konten,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            padding: EdgeInsets.only(left:10, right: 15),
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border_outlined,
                size: 20,
              ),
              padding: EdgeInsets.zero,
            ),
          )
        ],
      ),
    );

    // return ListTile(
    //   leading: Container(
    //     // constraints: const BoxConstraints(minWidth: 70.0, maxWidth: 80),
    //     // height: 120,
    //     // color: Colors.amber,
    //     child: AccountButton(
    //       onPressed: null,
    //       image: user.foto!,
    //     ),
    //   ),
    //   // minLeadingWidth: 5,

    // title: Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(
    //           user.username,
    //           style: Theme.of(context).textTheme.titleMedium,
    //         ),
    //         Text(
    //           DateFormat('dd/MM/yyyy hh.mm').format(komentar.tglDibuat),
    //           style: TextStyle(
    //               fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
    //               color: Theme.of(context)
    //                   .colorScheme
    //                   .secondary
    //                   .withOpacity(0.5)),
    //         ),
    //       ],
    //     ),
    //     Text(
    //       "aaaaaaaaaaaaaaaaaadasdasdasdasdasdadadadaaaaaaaaaaaaaaaaaadasdasdasdasdasdadadadaaaaaaaaaaaaaaaaaadasdasdasdasdasdadadadaaaaaaaaaaaaaaaaaadasdasdasdasdasdadadadaaaaaaaaaaaaaaaaaadasdasdasdasdasdadadadaaaaaaaaaaaaaaaaaadasdasdasdasdasdadadadaaaaaaaaaaaaaaaaaadasdasdasdasdasdadadadaaaaaaaaaaaaaaaaaadasdasdasdasdasdadadadaaaaaaaaaaaaaaaaaadasdasdasdasdasdadadadaaaaaaaaaaaaaaaaaadasdasdasdasdasdadadadaaaaaaaaaaaaaaaaaadasdasdasdasdasdadadadaaaaaaaaaaaaaaaaaadasdasdasdasdasdadadad",
    //       style: Theme.of(context).textTheme.bodyMedium,
    //     )
    //   ],
    // ),
    // );
  }
}
