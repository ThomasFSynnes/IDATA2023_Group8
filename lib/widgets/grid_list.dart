import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_manuals_app/widgets/display_card.dart';

class GridList extends ConsumerStatefulWidget {
  const GridList({
    super.key,
    required this.list,
  });

  final List list;
  
 
  
  @override
  ConsumerState<GridList> createState() {
     return _GridList();
  }


}
class _GridList extends ConsumerState<GridList>{
  @override
  Widget build(BuildContext context) {
    

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        return DisplayCard(item: widget.list[index]);
      },
    );
  }
}
