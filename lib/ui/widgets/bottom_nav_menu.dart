part of "widgets.dart";

class BottomNavMenu extends StatelessWidget {
  int index;

  BottomNavMenu({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor:
          Theme.of(context).colorScheme.secondary.withOpacity(0.5),
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: "Cari",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Pengaturan",
        ),
      ],
      currentIndex: index,
      onTap: (i) {
        if (i == 0) {
          Navigator.popAndPushNamed(context, "/");
        } else if (i == 1) {
          Navigator.popAndPushNamed(context, "/cari");
        } else if (i == 2) {
          Navigator.popAndPushNamed(context, "/pengaturan");
        }
      },
    );
  }
}
