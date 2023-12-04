// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:post_in/models/models.dart';
import 'package:post_in/providers/providers.dart';
import 'package:post_in/ui/pages/pages.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:post_in/ui/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModeData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageData()),
        ChangeNotifierProvider(create: (context) => AuthData()),
        ChangeNotifierProvider(create: (context) => UserData()),
        ChangeNotifierProvider(create: (context) => PostData()),
        ChangeNotifierProvider(create: (context) => KomentarData()),
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
              surface: colors["milk-white"],
              onSurface: colors["dark-jungle-green"],
            ),
            appBarTheme: AppBarTheme(
                scrolledUnderElevation: 0,
                color: colors["milk-white"],
                elevation: null,
                titleTextStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colors["sand"],
                ),
                iconTheme: IconThemeData(color: colors["sand"]!)),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors["sand"],
                foregroundColor: colors["milk-white"],
              ),
            ),
            iconTheme: IconThemeData(color: colors["sand"]),
            iconButtonTheme: IconButtonThemeData(
              style: IconButton.styleFrom(
                // backgroundColor: colors["milk-white"],
                surfaceTintColor: colors["milk-white"],
                shadowColor: Colors.transparent,
                foregroundColor: colors["sand"],
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  BorderSide(
                    color: colors["sand"]!,
                  ),
                ),
              ),
            ),
            filledButtonTheme: FilledButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(colors["sand"]),
                foregroundColor: MaterialStateProperty.all(
                  colors["dark-jungle-green"],
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: colors["sand"],
              ),
            ),
            textTheme: TextTheme(
              bodyLarge: TextStyle(
                fontSize: 18,
                color: colors["dark-jungle-green"],
              ),
              bodyMedium: TextStyle(
                fontSize: 16,
                color: colors["dark-jungle-green"],
              ),
              bodySmall: TextStyle(
                fontSize: 14,
                color: colors["dark-jungle-green"],
              ),
              titleLarge: TextStyle(
                fontSize: 18,
                color: colors["sand"],
                fontWeight: FontWeight.bold,
              ),
              titleMedium: TextStyle(
                fontSize: 16,
                color: colors["dark-jungle-green"],
                fontWeight: FontWeight.bold,
              ),
              titleSmall: TextStyle(
                fontSize: 14,
                color: colors["dark-jungle-green"],
                fontWeight: FontWeight.bold,
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: colors["dark-jungle-green"]!.withOpacity(0.5),
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
                borderSide: BorderSide(
                  color: colors["sand"]!,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusColor: colors["sand!"],
              hintStyle: TextStyle(
                color: colors["dark-jungle-green"]!.withOpacity(0.5),
              ),
                            labelStyle: TextStyle(
                  color: colors["dark-jungle-green"]!.withOpacity(0.5),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              floatingLabelStyle: TextStyle(
                color: colors["sand"],
                fontSize: 16,
              ),
            ),
            popupMenuTheme: PopupMenuThemeData(
              surfaceTintColor: colors["milk-white"]!,
            ),
            snackBarTheme: SnackBarThemeData(
              backgroundColor: colors["old-lavender"],
              actionTextColor: colors["sand"],
              contentTextStyle: TextStyle(
                color: colors["milk-white"],
                fontSize: 16,
              ),
            ),
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
              surface: colors["dark-jungle-green"],
              onSurface: colors["milk-white"],
            ),
            appBarTheme: AppBarTheme(
              scrolledUnderElevation: 0,
              color: colors["dark-jungle-green"],
              elevation: null,
              titleTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: colors["sand"],
              ),
              iconTheme: IconThemeData(color: colors["sand"]!),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors["sand"],
                foregroundColor: colors["milk-white"],
              ),
            ),
            iconTheme: IconThemeData(color: colors["sand"]),
            iconButtonTheme: IconButtonThemeData(
              style: IconButton.styleFrom(
                // backgroundColor: colors["dark-jungle-green"],
                surfaceTintColor: colors["dark-jungle-green"],
                shadowColor: Colors.transparent,
                foregroundColor: colors["sand"],
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  BorderSide(
                    color: colors["sand"]!,
                  ),
                ),
              ),
            ),
            filledButtonTheme: FilledButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(colors["sand"]),
                foregroundColor: MaterialStateProperty.all(
                  colors["dark-jungle-green"],
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: colors["sand"],
              ),
            ),
            textTheme: TextTheme(
              bodyLarge: TextStyle(
                fontSize: 18,
                color: colors["milk-white"],
              ),
              bodyMedium: TextStyle(
                fontSize: 16,
                color: colors["milk-white"],
              ),
              bodySmall: TextStyle(
                fontSize: 14,
                color: colors["milk-white"],
              ),
              titleLarge: TextStyle(
                fontSize: 18,
                color: colors["sand"],
                fontWeight: FontWeight.bold,
              ),
              titleMedium: TextStyle(
                fontSize: 16,
                color: colors["milk-white"],
                fontWeight: FontWeight.bold,
              ),
              titleSmall: TextStyle(
                fontSize: 14,
                color: colors["milk-white"],
                fontWeight: FontWeight.bold,
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: colors["milk-white"]!.withOpacity(0.5),
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
                borderSide: BorderSide(
                  color: colors["sand"]!,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusColor: colors["sand!"],
              hintStyle: TextStyle(
                color: colors["milk-white"]!.withOpacity(0.5),
              ),
              labelStyle: TextStyle(
                color: colors["milk-white"]!.withOpacity(0.5),
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
              floatingLabelStyle: TextStyle(
                color: colors["sand"],
                fontSize: 16,
              ),
            ),
            popupMenuTheme: PopupMenuThemeData(
              surfaceTintColor: colors["dark-jungle-green"]!,
            ),
            snackBarTheme: SnackBarThemeData(
              backgroundColor: colors["old-lavender"],
              actionTextColor: colors["sand"],
              contentTextStyle: TextStyle(
                color: colors["milk-white"],
                fontSize: 16,
              ),
            ),
          ),

          // theme yg digunakan ==============================================================
          themeMode: Provider.of<ThemeModeData>(context).themeMode,
          //themeMode: ThemeMode.system,

          // routes ==============================================================
          routes: {
            "/": (ctx) => const MainPage(),
            "/intro": (ctx) => const Introduction_Page(),
            "/sign-in": (ctx) => const SignIn(),
            "/sign-up": (ctx) => const SignUp(),
            "/landing": (ctx) => const landingPage(),
            "/post": (ctx) => const PostPage(),
            "/profile": (ctx) => const ProfilePage(),
            "/follow": (ctx) => const FollowPage(),
            "/edit": (ctx) => EditPage(),
            "/pengaturan": (ctx) => const PengaturanPage(),

            // !!!!!!!! NANTI HAPUSS !!!!!!!!,
            "/debug": (ctx) => const DebugPage(),
          },
          initialRoute:
              FirebaseAuth.instance.currentUser != null ? "/" : "/intro",

          // initialRoute: "/debug",
        );
      }),
    );
  }
}
