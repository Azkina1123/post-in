part of "widgets.dart";

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      height: 60,
      padding: EdgeInsets.only(left: 20, right: 20),
      margin: EdgeInsets.only(top: 20),

      // isian postingan ---------------------------------------------------------
      child: TextField(
        decoration: InputDecoration(
          hintText: "Ceritakan kisah Anda hari ini!",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding:
              EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          focusColor: Theme.of(context).colorScheme.primary,
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
          icon: AccountButton(
            image: NetworkImage(
                "https://avatars.githubusercontent.com/azkina1123"),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
