part of "pages.dart";

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // int _index = 0;

  final List<Widget> _pages = [
    const PostsPage(),
    const CariPage(),
    const PengaturanPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, pageProvider, child) {
        return Scaffold(
          body: _pages.elementAt(
          pageProvider.currentIndex,
        ),

          // bottom navigation
          bottomNavigationBar: BottomNavigationBar(
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
            currentIndex: pageProvider.currentIndex,
            onTap: (i) {
              pageProvider.changePage(i);
            },
          ),
        );
      }
    );
  }
}
