part of "widgets.dart";

class AccountButton extends StatefulWidget {
  void Function()? onPressed;
  ImageProvider<Object> image;
  AccountButton({super.key, required this.onPressed, required this.image});

  @override
  State<AccountButton> createState() => _AccountButtonState();
}

class _AccountButtonState extends State<AccountButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: Container(
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: widget.image,
            // fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
