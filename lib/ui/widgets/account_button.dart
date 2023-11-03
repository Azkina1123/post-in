part of "widgets.dart";

class AccountButton extends StatelessWidget {
  void Function()? onPressed;
  ImageProvider<Object> image;
  AccountButton({super.key, required this.onPressed, required this.image});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: image,
            // fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
