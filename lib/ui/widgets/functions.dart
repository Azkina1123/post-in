part of "widgets.dart";

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

ButtonStyle elevatedBtnStyle(BuildContext context) {
  return ButtonStyle(
    backgroundColor:
        MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
    foregroundColor: MaterialStateProperty.all(
      Theme.of(context).colorScheme.background,
    ),
  );
}

ButtonStyle outlinedBtnStyle(BuildContext context) {
  return ButtonStyle(
    side: MaterialStateProperty.all(
      BorderSide(
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );
}

ButtonStyle iconButtonStyle(BuildContext context, Color foregroundColor) {
  return ElevatedButton.styleFrom(
    backgroundColor: Theme.of(context).colorScheme.background,
    surfaceTintColor: Theme.of(context).colorScheme.background,
    shadowColor: Colors.transparent,
    foregroundColor: foregroundColor
  );
}
