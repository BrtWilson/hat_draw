import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hat_draw_app/hdw_classes/category_tile.dart';
import 'package:hat_draw_app/hdw_classes/draw_button.dart';
import 'package:hat_draw_app/hdw_state.dart';

class ItemsPage extends StatelessWidget {
  ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Map;
    String _catName = arg['catName'];
    int _index = context.watch<HdwState>().sCategories.indexOf(_catName);
    List<String> _itemList = context.watch<HdwState>().sCatContents[_index].mItems;

    return Scaffold(
        appBar: AppBar(
          title: Text("Hat Draw"),
        ),
        body: ItemsPageContent(catName: _catName, catItems: _itemList, ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

class ItemsPageContent extends StatefulWidget {
  const ItemsPageContent({
    Key? key,
    required String catName,
    required List<String> catItems,
  })
      : _catName = catName,
        _catItems = catItems,
        super(key: key);

  final String _catName;
  final List<String> _catItems;

  @override
  State<ItemsPageContent> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPageContent> {

  @override
  Widget build(BuildContext context) {
    //List<Widget> items = context.watch<HdwState>().sCategories.map((c_name) => CategoryTile(name: c_name, )).toList();
    List<Widget> items = widget._catItems.map((i_name) => CategoryTile(name: i_name, isChild: true,)).toList();
    items.add(CategoryTile(name: "New Category", parentCat: widget._catName, isChild: true, isNew: true,));
    // List<Widget> items = widget._catItems.map((item) => CategoryTile(name: item, parentCat: widget._catName)).toList(); //_catItems.map((c_name) => CategoryTile(name: c_name, checkedItems: context.watch<HdwState>().sCurrentItems, setInclusion: context.watch<HdwState>().setItemInclusion)).toList();
    // items.add(CategoryTile(name: "New Item", parentCat: widget._catName, isNew: true,));

    return Column(
        children: [
          CategoryTile(name: widget._catName,),
          Container(
              height: 600,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: items ?? [],
              )
          ),
          DrawButton(items: context.watch<HdwState>().sCurrentItems),
        ]
    );
  }
}