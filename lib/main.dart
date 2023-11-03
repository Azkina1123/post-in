import 'package:flutter/material.dart';
import 'package:post_in/models/models.dart';
import 'package:post_in/providers/providers.dart';
import 'package:post_in/ui/pages/pages.dart';
import 'package:provider/provider.dart';
// import 'package:post_in/ui/widgets/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageProvider()),
        ChangeNotifierProvider(create: (context) => PostProvider()),
      ],
      child: Builder(builder: (ctx) {
        return MaterialApp(
          title: 'Post.In',
          debugShowCheckedModeBanner: false,

          // light mode =============================================================
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: colors["sand"]!,
              background: colors["milk-white"],
              onBackground: colors["dark-jungle-green"],
              primary: colors["sand"],
              onPrimary: colors["milk-white"],
              secondary: colors["dark-jungle-green"],
              onSecondary: colors["milk-white"],
              tertiary: colors["languid-lavender"],
              onTertiary: colors["dark-jungle-green"],
              error: colors["smoky-topaz"],
              onError: colors["milk-white"],
              onSurface: colors["dark-jungle-green"],
            ),
            appBarTheme: AppBarTheme(
              color: colors["milk-white"],
              elevation: null,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors["sand"],
                foregroundColor: colors["milk-white"],
              ),
            ),
            iconTheme: IconThemeData(
              color: colors["sand"]
            )
          ),

          // dark mode ==============================================================
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: colors["sand"]!,
              background: colors["dark-jungle-green"],
              onBackground: colors["milk-white"],
              primary: colors["sand"],
              onPrimary: colors["milk-white"],
              secondary: colors["milk-white"],
              onSecondary: colors["dark-jungle-green"],
              tertiary: colors["languid-lavender"],
              onTertiary: colors["dark-jungle-green"],
              error: colors["smoky-topaz"],
              onError: colors["milk-white"],
              onSurface: colors["milk-white"],
            ),
            appBarTheme: AppBarTheme(color: colors["dark-jungle-green"]),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors["sand"],
                foregroundColor: colors["milk-white"],
              ),
            ),
            iconTheme: IconThemeData(color: colors["sand"])
          ),

          themeMode: ThemeMode.dark,

          // home: MainPage(),

          routes: {
            "/": (ctx) => const MainPage(),
            // "/cari": (ctx) => const CariPage(),
            // "/pengaturan": (ctx) => const PengaturanPage(),
            "/profile": (ctx) => const ProfilePage(),
          },

          initialRoute: "/",
        );
      }),
    );
  }
}
