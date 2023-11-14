import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:user_manuals_app/data/dummy_data.dart';
import 'package:user_manuals_app/screens/new_manual.dart';
import 'package:user_manuals_app/screens/settings/localization.dart';
import 'package:user_manuals_app/screens/settings/login_screen.dart';

import 'package:user_manuals_app/widgets/menu_button.dart';

import 'package:user_manuals_app/model/product.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: Theme.of(context).colorScheme.onBackground,
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Column(
          children: [
            const SizedBox(height: 24),
            MenuButton(
              navigateTo:
                  MaterialPageRoute(builder: (ctx) => const Localization()),
              title: "sideDrawer.text.Localization".tr(),
              icon: const Icon(Icons.language, color: Colors.black54),
            ),
            ElevatedButton(
              onPressed: () async {
                final newProduct = await Navigator.of(context).push<Product>(
                  MaterialPageRoute(
                    builder: (ctx) => const NewManual(),
                  ),
                );

                if (newProduct != null) {
                  setState(() {
                    products.add(newProduct);
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                primary: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              child: Row(
                children: [
                  const Icon(Icons.upload_file, color: Colors.black54),
                  const SizedBox(width: 8),
                  Text(
                    "sideDrawer.buttons.addManual".tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const Spacer(),
            //Todo: only show if user is logged in
            MenuButton(
              navigateTo:
                  MaterialPageRoute(builder: (ctx) => const LoginScreen()),
              title: "sideDrawer.buttons.login".tr(),
              icon: const Icon(Icons.login, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
