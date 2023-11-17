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
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Cari',
              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle!,
            ),
          ),
        ),
      ),
      body: DefaultTabController(
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
              indicatorColor: Theme.of(context).colorScheme.primary, 
              indicatorWeight: 2,
              dividerColor: Theme.of(context)
                  .colorScheme
                  .tertiary
                  .withOpacity(0.5),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(
                    child: Text(
                      "Nanti diisi sama history akun yang dicari"
                    )
                  ),
                  Center(
                    child: Text(
                      "Nanti diisi sama history postingan yang dicari"
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}