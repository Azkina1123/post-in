import 'package:flutter/material.dart';

class follow extends StatefulWidget {
  const follow({super.key});

  @override
  State<follow> createState() => _followState();
}

class _followState extends State<follow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: const [Tab(text: "Following"), Tab(text: "Followers")],
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                fontWeight: FontWeight.bold,
              ),
              labelPadding: EdgeInsets.only(left: 10, right: 10),
              dividerColor:
                  Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
