import 'package:flutter/material.dart';
import 'package:user_manuals_app/model/product.dart';
import 'package:user_manuals_app/widgets/grid_list.dart';

class ProductSeachDeligate extends SearchDelegate{
  ProductSeachDeligate({required this.searchList});

  final List searchList;
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = "";
      }, icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Product> matchQuery = [];
    for (var item in searchList) {
      if (item.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return GridList(list: matchQuery);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> matchQuery = [];
    for (var item in searchList) {
      if (item.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return GridList(list: matchQuery);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: searchFieldDecorationTheme,
      textTheme: Theme.of(context).textTheme.copyWith(
        titleLarge: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white),
      ),
    );
  }

}