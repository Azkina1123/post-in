part of "widgets.dart";

class UserPost extends StatefulWidget {
  Post post;
  // ImageProvider<Object>? image;
  UserPost({super.key, required this.post});

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: AccountButton(
            onPressed: () {
              setState(() {
                Navigator.pushNamed(context, "/profile");
              });
            },
            image: NetworkImage(
                "https://avatars.githubusercontent.com/azkina1123"),
          ),
          title: Text("Username"),
          subtitle: Text(
            widget.post.createdAt.toString(),
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                fontSize: Theme.of(context).textTheme.bodySmall!.fontSize),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              widget.post.img != null
                  ? Container(
                      width: width(context),
                      height: 200,
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: widget.post.img!, fit: BoxFit.cover),
                      ),
                    )
                  : SizedBox(),
              Text(
                 widget.post.content),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline, ), ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_outline,
                    ),
                    style: iconButtonStyle(
                        context, Theme.of(context).colorScheme.secondary),
                    label: Text("123"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add_comment_outlined),
                    style: iconButtonStyle(
                        context, Theme.of(context).colorScheme.secondary),
                    label: Text("123"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
