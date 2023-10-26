part of "widgets.dart";

class BottomNavMenu extends StatefulWidget {
  int index;
  BottomNavMenu({super.key, required this.index});

  @override
  State<BottomNavMenu> createState() => _BottomNavMenuState();
}

class _BottomNavMenuState extends State<BottomNavMenu> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      
      unselectedItemColor:
          Theme.of(context).colorScheme.secondary.withOpacity(0.5),
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded), label: "Cari"),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), label: "Pengaturan"),
      ],
      currentIndex: widget.index,
      onTap: (i) {
        setState(() {
          widget.index = i;
        });
      },
    );
  }
}
