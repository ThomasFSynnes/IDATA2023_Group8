import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Localization extends StatelessWidget {
  const Localization({super.key});

  @override
  Widget build(BuildContext context) {
    //Language Button

    Widget setLanguageEN = TextButton(
        onPressed: () {
          context.setLocale(const Locale("en", "US"));
        },
        child: const Text("English"));

    Widget setLanguageNO = TextButton(
        onPressed: () {
          context.setLocale(const Locale("no", "NO"));
        },
        child: const Text("Norsk"));

    return Scaffold(
      appBar: AppBar(
        title: Text("sideDrawer.text.Localization".tr()),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 24),
            setLanguageEN,
            setLanguageNO,
          ],
        ),
      ),
    );
  }
}
