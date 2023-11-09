import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:user_manuals_app/screens/settings/localization.dart';
import 'package:user_manuals_app/screens/settings/login_screen.dart';
import 'package:user_manuals_app/screens/settings/uploade_manual.dart';
import 'package:user_manuals_app/widgets/menu_button.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: Theme.of(context).colorScheme.onBackground,
      backgroundColor: Color.fromARGB(255, 0, 70, 67),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Column(
          children: [
            const SizedBox(height: 24),
            MenuButton(
              navigateTo:
                  MaterialPageRoute(builder: (ctx) => const Localization()),
              title: "sideDrawer.text.Localization".tr(),
              icon: const Icon(Icons.language,color: Colors.black54),
            ),
            MenuButton(
              navigateTo:
                  MaterialPageRoute(builder: (ctx) => const UploadeManual()),
              title: "sideDrawer.buttons.addManual".tr(),
              icon: const Icon(Icons.upload_file,color: Colors.black54),
            ),
            const Spacer(),
            //Todo: only show if user is logged in
            MenuButton(
              navigateTo:
                  MaterialPageRoute(builder: (ctx) => const LoginScreen()),
              title: "sideDrawer.buttons.login".tr(),
              icon: const Icon(Icons.login,color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
