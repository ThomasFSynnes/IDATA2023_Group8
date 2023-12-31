import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:user_manuals_app/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:user_manuals_app/util/database_manager.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

//**
// Entry point for app
// Defines theme, ensures components are initialized, gets data from database and displays the main page
//
// */

//defining the theme for the APP both color and text theme
final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color(0xFF001E1D),
    onBackground: const Color(0xFF001E1D),
    onSecondary: const Color(0xFFABD1C6),
    onPrimaryContainer: const Color(0xFFE8E4E6),
    onSecondaryContainer: const Color(0xffF9BC60),
    error: const Color.fromARGB(255, 206, 78, 39),
    onErrorContainer: const Color.fromARGB(255, 219, 142, 118),
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
  WidgetsFlutterBinding
      .ensureInitialized(); // Initialization tasks before running the app
  await EasyLocalization
      .ensureInitialized(); // Ensure EasyLocalization is initialized for translations
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions
          .currentPlatform); // Initialize Firebase with options from FirebaseOptions.currentPlatform
  await DatabaseManager()
      .getAllProducts(); // Fetch data from the database using DatabaseManager

  runApp(
    EasyLocalization(
      // Initialize EasyLocalization for multi-language support
      supportedLocales: const [
        Locale("en", "US"),
        Locale("no", "NO"),
      ],
      path: "assets/translations", // Path to translation files
      fallbackLocale: const Locale("en", "US"),
      child: const ProviderScope(
        child: App(),
      ),
    ),
  );
}

// Root widget for the application
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp that configures the app with EasyLocalization, theme, and initial route
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: theme,
      builder: EasyLoading.init(), // Initialize Flutter EasyLoading
      home: const MainPage(), // Set the initial page as MainPage
    );
  }
}
