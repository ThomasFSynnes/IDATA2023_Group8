import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:user_manuals_app/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final darkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color(0xFF001E1D),
  onBackground: const Color(0xFF001E1D),
  onSecondary: const Color(0xFFABD1C6),
  onPrimaryContainer: const Color(0xFFE8E4E6),
  onSecondaryContainer: const Color(0xffF9BC60),
);

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      color: Color(0xFF001E1D),
      fontSize: 15,
      fontFamily: 'Cabin',
      fontWeight: FontWeight.w700,
      height: 0,
    ),
    titleLarge: TextStyle(
      color: Color(0xFF001E1D),
      fontSize: 17,
      fontFamily: 'Cabin',
      fontWeight: FontWeight.w700,
    ),
    titleSmall: TextStyle(
      color: Color(0xFF001E1D),
      fontSize: 12,
      fontFamily: 'Cabin',
      fontWeight: FontWeight.w400,
      height: 0,
    ),
    bodyLarge: TextStyle(
      color: Color(0xFF001E1D),
    ),
  ),
);

final lightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color(0xFFE8E4E6),
  primary: const Color(0xFFABD1C6),
  onPrimary: const Color(0xFF001E1D),
);

ThemeData lightTheme(bool isDark) {
  return ThemeData(
    primarySwatch: Colors.lightGreen,
    brightness: isDark ? Brightness.dark : Brightness.light,
    scaffoldBackgroundColor: isDark ? Colors.black : Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: isDark ? Colors.grey : Colors.lightGreen,
      iconTheme: IconThemeData(
        color: isDark ? Colors.white : Colors.black,
      ),
      titleTextStyle: TextStyle(
        color: isDark ? Colors.white : Colors.black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: isDark ? Colors.black : Colors.white,
        backgroundColor: isDark ? Colors.green : Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  );
}

void main() async {
  //used for localization
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale("en", "US"),
        Locale("no", "NO"),
      ],
      path: "assets/translations",
      fallbackLocale: const Locale("en", "US"),
      child: const ProviderScope(
        child: App(),
      ),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _iconBool = false;

  final IconData _iconLight = Icons.wb_sunny;
  final IconData _iconDark = Icons.nights_stay;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: _iconBool ? lightTheme(true) : theme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Our App"),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _iconBool = !_iconBool;
                });
              },
              icon: Icon(
                _iconBool ? _iconDark : _iconLight,
                color: _iconBool ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
        body: MainPage(),
      ),
    );
  }
}
