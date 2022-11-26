import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_classes/category_tile_holder.dart';
import 'package:hat_draw_app/hdw_classes/current_selection_tile.dart';
import 'package:provider/provider.dart';
import 'package:hat_draw_app/hdw_classes/category_tile.dart';
import 'package:hat_draw_app/hdw_classes/draw_button.dart';
import 'package:hat_draw_app/hdw_state.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({
    Key? key,
  }) : super(key: key); //_state = state, super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> categories = context.watch<HdwState>().sCategories.map((c_name) => CategoryTileHolder(name: c_name, )).toList();
    categories.add(CategoryTileHolder(name: "New Category", isNew: true,));
    categories.insert(0, CategoryTileHolder(name: " Current Selection "));

    double keyOverflow = 0.0;
    if (MediaQuery.of(context).viewInsets.bottom != 0) keyOverflow = 208;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hat Draw"),
      ),
      body:
        Column(
          children: [
            SizedBox(
              height: 600 - keyOverflow,
              width: 400,
              child: ListView(
                key: const Key("CategoryList"),
                padding: const EdgeInsets.all(16.0),
                children: categories, //context.watch<HdwState>().sCategories.map((c_name) => CategoryTile(name: c_name, checkedItems: context.watch<HdwState>().sCurrentItems, setInclusion: context.watch<HdwState>().setItemInclusion)).toList(),
              )
            ),
            if (keyOverflow == 0.0) DrawButton(items: context.watch<HdwState>().sCurrentItems),
          ]
        ),
    );
  }
}