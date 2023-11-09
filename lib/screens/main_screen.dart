import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:user_manuals_app/data/dummy_data.dart';
import 'package:user_manuals_app/providers/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_manuals_app/screens/side_drawer.dart';
import 'package:user_manuals_app/widgets/horizontal_list.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final products = ref.read(productProvider);
      return Scaffold(
        backgroundColor:
            Theme.of(context).colorScheme.onSecondary, //TODO: FIX COLORS
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 50, //TODO: ADD SEARCH WIDGET
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  18, 10, 0, 0), // Adjust the left padding as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Products".tr(),
                      style: Theme.of(context).textTheme.titleMedium),
                  TextButton(
                    onPressed: () {
                      // TODO: See all
                    },
                    child: Text(
                      'See More'.tr(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  )
                ],
              ),
            ),
            HorizontalList(list: products.toList()),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  18, 0, 0, 0), // Adjust the left padding as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Manufacturers'.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: See all
                    },
                    child: Text(
                      'See More'.tr(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  )
                ],
              ),
            ),
            const HorizontalList(list: availableManufactures),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  18, 0, 0, 0), // Adjust the left padding as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories".tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: See all
                    },
                    child: Text(
                      'See More'.tr(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),
            const HorizontalList(list: availableCategories)
          ]),
        ),
        appBar: AppBar(),
        //Todo: Bug, app crashes when opening drawer by swiping.
        drawer: const SideDrawer(),
      );
    });
  }
}
