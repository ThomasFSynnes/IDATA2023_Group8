import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:user_manuals_app/widgets/menu_button.dart';
import 'package:user_manuals_app/screens/settings/change_email.dart';
import 'package:user_manuals_app/screens/settings/change_password.dart';

import 'package:firebase_auth/firebase_auth.dart';

//TODO: ADD MORE COMMENTS

User? user = FirebaseAuth.instance.currentUser;
String userEmail = user?.email ?? "";

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        title: Text(
          "sideDrawer.text.UserPage".tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              'Hello, $userEmail!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              width: 300,
              child: Column(children: [
                MenuButton(
                  navigateTo: MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen()),
                  title: "sideDrawer.buttons.change".tr(),
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  icon: const Icon(Icons.password, color: Colors.black54),
                ),
                const SizedBox(
                  height: 8,
                ),
                MenuButton(
                  navigateTo: MaterialPageRoute(
                      builder: (context) => const ChangeEmailPage()),
                  title: "ChangeEmail.changeEmail".tr(),
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  icon: const Icon(Icons.email, color: Colors.black54),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
