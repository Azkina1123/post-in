part of "widgets.dart";

class AkunWidget extends StatelessWidget {
  UserAcc? user;
  AkunWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //     AccountButton(
    //       onPressed: null,
    //       image: NetworkImage(user?.foto ?? ""),
    //     ),
    //   ],
    // );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: Image.network(user?.foto ?? "").image,
              ),
              SizedBox(width: 15),
              Column(
                children: [
                  Text(
                    user?.username ?? "",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize:
                          Theme.of(context).textTheme.titleLarge!.fontSize,
                    ),
                  ),
                  Text(
                    user?.namaLengkap ?? "",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize,
                    ),
                  ),
                ],
              ),
              Spacer(),
              PopupMenuButton(itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'delete',
                    child: const Text('Delete'),
                    onTap: () {},
                  )
                ];
              }),
            ],
          ),
        ),
      ],
    );
  }
}
