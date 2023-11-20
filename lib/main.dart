import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:user_manuals_app/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color(0xFF001E1D),
    onBackground: const Color(0xFF001E1D),
    onSecondary: const Color(0xFFABD1C6),
    onPrimaryContainer: const Color(0xFFE8E4E6),
  ),
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
      )),
);

void main() async {
  //used for localization
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(/* options: DefaultFirebaseOptions.currentPlatform */);

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

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: theme,
      home: const MainPage(),
    );
  }
}
