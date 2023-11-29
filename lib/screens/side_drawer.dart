import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_manuals_app/data/products.dart';
import 'package:user_manuals_app/screens/new_manual.dart';
import 'package:user_manuals_app/screens/settings/localization.dart';
import 'package:user_manuals_app/screens/settings/login_screen.dart';
import 'package:user_manuals_app/screens/settings/userPage.dart';
import 'package:user_manuals_app/util/database_manager.dart';

import 'package:user_manuals_app/widgets/menu_button.dart';

import 'package:user_manuals_app/model/product.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  DatabaseManager database = DatabaseManager();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Column(
          children: [
            const SizedBox(height: 32),
            MenuButton(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              navigateTo:
                  MaterialPageRoute(builder: (ctx) => const Localization()),
              title: "sideDrawer.text.Localization".tr(),
              icon: const Icon(Icons.language, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            //Show different button based on login state.
            StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final newProduct =
                              await Navigator.of(context).push<Product>(
                            MaterialPageRoute(
                              builder: (ctx) => const NewManual(),
                            ),
                          );

                          if (newProduct != null) {
                            setState(() {
                              products.add(newProduct);
                              DatabaseManager().addProduct(newProduct);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.upload_file,
                                color: Colors.black54),
                            const SizedBox(width: 8),
                            Text(
                              "sideDrawer.buttons.addManual".tr(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        onPressed: () async {
                          await DatabaseManager().syncFavorites();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => ProductsScreen(
                                products: favorits,
                                pageTitle: "sideDrawer.buttons.favourites".tr(),
                                image: "",
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.black54),
                            const SizedBox(width: 8),
                            Text(
                              "sideDrawer.buttons.favourites".tr(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  //login button
                  return Text(
                    "sideDrawer.buttons.upload".tr(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  );
                }
              },
            ),

            //Show different button based on login state.
            const Spacer(),
            StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      MenuButton(
                        navigateTo: MaterialPageRoute(
                            builder: (context) => const UserPage()),
                        title: "sideDrawer.text.UserPage".tr(),
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        icon: const Icon(Icons.person, color: Colors.black54),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.onErrorContainer),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          favorits.clear();
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.logout, color: Colors.black54),
                            const SizedBox(width: 8),
                            Text(
                              "sideDrawer.buttons.logout".tr(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                  //logout button
                } else {
                  // login button
                  return MenuButton(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    navigateTo: MaterialPageRoute(
                        builder: (ctx) => const LoginScreen()),
                    title: "sideDrawer.buttons.login".tr(),
                    icon: const Icon(Icons.login,
                        color: Color.fromARGB(255, 5, 139, 95)),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
