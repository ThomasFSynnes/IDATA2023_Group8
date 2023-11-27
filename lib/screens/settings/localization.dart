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
        child: Text("English", style: Theme.of(context).textTheme.titleMedium));

    Widget setLanguageNO = TextButton(
        onPressed: () {
          context.setLocale(const Locale("no", "NO"));
        },
        child: Text("Norsk", style: Theme.of(context).textTheme.titleMedium));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        title: Text(
          "sideDrawer.text.Localization".tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
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
