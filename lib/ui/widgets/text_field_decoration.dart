part of "widgets.dart";

InputDecoration textFieldDecoration(BuildContext context,
    {required String hintText, Widget? icon}) {
  return InputDecoration(
    hintText: hintText,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.only(
      top: 10,
      bottom: 10,
      left: 15,
      right: 15,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
      borderRadius: BorderRadius.circular(10),
    ),
    focusColor: Theme.of(context).colorScheme.primary,
    hintStyle: TextStyle(
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
    ),
    icon: icon,
  );
}
