import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hat_draw_app/hdw_classes/category_contents.dart';
import 'package:hat_draw_app/hdw_classes/category_tile.dart';
import 'package:hat_draw_app/hdw_classes/draw_button.dart';
import 'package:hat_draw_app/hdw_state.dart';
import 'package:hat_draw_app/new_category_tile.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({
    Key? key,
  }) : super(key: key); //_state = state, super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> categories = context.watch<HdwState>().sCategories.map((c_name) => CategoryTile(name: c_name, )).toList();
    categories.add(CategoryTile(name: "New Category", isNew: true,));

    return Scaffold(
      appBar: AppBar(
        title: Text("Hat Draw"),
      ),
      body:
        Column(
          children: [
            Container(
              height: 600,
              child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: categories, //context.watch<HdwState>().sCategories.map((c_name) => CategoryTile(name: c_name, checkedItems: context.watch<HdwState>().sCurrentItems, setInclusion: context.watch<HdwState>().setItemInclusion)).toList(),
              )
            ),
            DrawButton(items: context.watch<HdwState>().sCurrentItems),
          ]
        ),
    );
  }
}

class Category extends StatefulWidget {
  const Category({
    Key? key,
    required int index,
    required String catName,
    required CategoryContents catSet,
  }) : _index = index, _catName = catName, _catSet = catSet, super(key: key);

  final int _index;
  final String _catName;
  final CategoryContents _catSet;

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  @override
  Widget build(BuildContext context) {  //Widget categoryCard( String catName ) {
    return Card(
        margin: const EdgeInsets.fromLTRB(16.0,16.0,16.0,10.0),
        child: Row(
          children: [
            Text(
                widget._catName,
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[600]
                )
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row (
                  children: <Widget>[
                    Icon(
                      Icons.edit,
                      color: Colors.grey[500],
                      size: 25.0,
                    ),
                    Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey[500],
                      size: 25.0,
                    ),
                  ]
              ),
            ),
          ],
        )
    );
  }
}
