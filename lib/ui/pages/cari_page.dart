part of "pages.dart";

class CariPage extends StatefulWidget {
  const CariPage({super.key});

  @override
  State<CariPage> createState() => _CariPageState();
}

class _CariPageState extends State<CariPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25.0),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Cari',
                  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle!,
                ),
              ),
            ),
          ),
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: const [
                    Tab(text: "Akun"),
                    Tab(text: "Postingan")
                  ],
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  labelPadding: EdgeInsets.only(left: 10, right: 10),
                  dividerColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
