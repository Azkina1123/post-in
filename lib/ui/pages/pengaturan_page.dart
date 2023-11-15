part of "pages.dart";

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Pengaturan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Row(
                children: [
                  Icon(Icons.person,
                  color: Theme.of(context).colorScheme.secondary,),
                  SizedBox(width: 10),
                  Text(
                    "Akun",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                ],
              ),
              Divider(
                height: 20,
                thickness: 1,
              ),
              Row(
                children: [
                  Text(
                    "Ubah Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Icon(Icons.navigate_next,
                  color: Theme.of(context).colorScheme.secondary),
                  SizedBox(height: 10),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Icon(Icons.navigate_next,
                  color: Theme.of(context).colorScheme.secondary),
                  SizedBox(height: 10),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Keluar Akun",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  Icon(Icons.navigate_next,
                  color: Theme.of(context).colorScheme.error),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Icon(Icons.sunny,
                  color: Theme.of(context).colorScheme.secondary,),
                  SizedBox(width: 10),
                  Text(
                    "Tampilan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                ],
              ),
              Divider(
                height: 20,
                thickness: 1,
              ),
              // RadioListTile<ThemeMode>(
              //     title: Text(
              //       "Default System",
              //       style: Theme.of(context).textTheme.bodyMedium,
              //     ),
              //     value: ThemeMode.system,
              //     groupValue: themeModeData.themeMode,
              //     activeColor: Provider.of<ThemeModeData>(context).buttonColor,
              //     onChanged: (ThemeMode? value) {
              //       if (value != null) {
              //         Provider.of<ThemeModeData>(context, listen: false)
              //             .changeTheme(value);
              //       }
              //     },
              //   ),
              //   RadioListTile<ThemeMode>(
              //     title: Text(
              //       "Light Mode",
              //       style: Theme.of(context).textTheme.bodyMedium,
              //     ),
              //     value: ThemeMode.light,
              //     groupValue: themeModeData.themeMode,
              //     activeColor: Provider.of<ThemeModeData>(context).buttonColor,
              //     onChanged: (ThemeMode? value) {
              //       if (value != null) {
              //         Provider.of<ThemeModeData>(context, listen: false)
              //             .changeTheme(value);
              //       }
              //     },
              //   ),
              //   RadioListTile<ThemeMode>(
              //     title: Text(
              //       "Dark Mode",
              //       style: Theme.of(context).textTheme.bodyMedium,
              //     ),
              //     value: ThemeMode.dark,
              //     groupValue: themeModeData.themeMode,
              //     activeColor: Provider.of<ThemeModeData>(context).buttonColor,
              //     onChanged: (ThemeMode? value) {
              //       if (value != null) {
              //         Provider.of<ThemeModeData>(context, listen: false)
              //             .changeTheme(value);
              //       }
              //     },
              //   ),
            ],
          ),
        ));
  }
}
