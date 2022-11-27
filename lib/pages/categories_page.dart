import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_classes/tiles/hdw_tile.dart';
import 'package:provider/provider.dart';
import 'package:hat_draw_app/hdw_classes/draw_button.dart';
import 'package:hat_draw_app/hdw_state.dart';

import '../hdw_constants.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({
    Key? key,
  }) : super(key: key); //_state = state, super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> categories = context.watch<HdwState>().sCategories.map((c_name) => HdwTile(name: c_name, )).toList();
    categories.add(const HdwTile(name: "New Category", isNew: true,));
    categories.insert(0, const HdwTile(name: HdwConstants.currentSelection));

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
              //child: Expanded(
                child:
                  ListView(
                    shrinkWrap: true,
                    key: const Key("CategoryList"),
                    padding: const EdgeInsets.all(16.0),
                    children: categories, //context.watch<HdwState>().sCategories.map((c_name) => CategoryTile(name: c_name, checkedItems: context.watch<HdwState>().sCurrentItems, setInclusion: context.watch<HdwState>().setItemInclusion)).toList(),
                ),
              //),
            ),
            if (keyOverflow == 0.0) DrawButton(items: context.watch<HdwState>().sCurrentItems),
          ]
        ),
    );
  }
}