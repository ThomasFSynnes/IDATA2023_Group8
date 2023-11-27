import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:user_manuals_app/data/categories.dart';
import 'package:user_manuals_app/data/manufacturers.dart';

import 'package:user_manuals_app/providers/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_manuals_app/screens/products.dart';
import 'package:user_manuals_app/screens/side_drawer.dart';
import 'package:user_manuals_app/widgets/horizontal_list.dart';
import 'package:user_manuals_app/widgets/vertical_list.dart';

final showListViewProvider = StateNotifierProvider<ShowListViewNotifier, bool>(
  (ref) => ShowListViewNotifier(),
);

class ShowListViewNotifier extends StateNotifier<bool> {
  ShowListViewNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final products = ref.read(productProvider);

        return Scaffold(
          backgroundColor: Theme.of(context)
              .colorScheme
              .onPrimaryContainer, //TODO: FIX COLORS
          body: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 50, //TODO: ADD SEARCH WIDGET
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  18,
                  10,
                  0,
                  0,
                ), // Adjust the left padding as needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Products".tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.view_module),
                          onPressed: () {
                            ref.read(showListViewProvider.notifier).toggle();
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => ProductsScreen(
                                  products: products,
                                  pageTitle: "Products".tr(),
                                  image: "",
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'See More'.tr(),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ref.watch(showListViewProvider)
                  ? VerticalList(items: products.toList())
                  : HorizontalList(list: products.toList()),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  18,
                  0,
                  0,
                  0,
                ), // Adjust the left padding as needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Manufacturers'.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.view_module),
                          onPressed: () {
                            ref.read(showListViewProvider.notifier).toggle();
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => ProductsScreen(
                                  products: manufactureObjects,
                                  pageTitle: 'Manufacturers'.tr(),
                                  image: "",
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'See More'.tr(),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ref.watch(showListViewProvider)
                  ? VerticalList(items: manufactureObjects)
                  : HorizontalList(list: manufactureObjects),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  18,
                  0,
                  0,
                  0,
                ), // Adjust the left padding as needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories".tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.view_module),
                          onPressed: () {
                            ref.read(showListViewProvider.notifier).toggle();
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => ProductsScreen(
                                  products: categoryObjects,
                                  pageTitle: "Categories".tr(),
                                  image: "",
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'See More'.tr(),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ref.watch(showListViewProvider)
                  ? VerticalList(items: categoryObjects)
                  : HorizontalList(list: categoryObjects),
            ]),
          ),
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          //Todo: Bug, app crashes when opening drawer by swiping.
          drawer: const SideDrawer(),
        );
      },
    );
  }
}
