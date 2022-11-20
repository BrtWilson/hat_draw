import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_classes/category_tile_holder.dart';
import 'package:provider/provider.dart';
import 'package:hat_draw_app/hdw_classes/category_tile.dart';
import 'package:hat_draw_app/hdw_classes/draw_button.dart';
import 'package:hat_draw_app/hdw_state.dart';

class ItemsPage extends StatelessWidget {
  ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Map;
    String catName = arg['catName'];
    int index = context.watch<HdwState>().sCategories.indexOf(catName);
    List<String> itemList = context.watch<HdwState>().sCatContents[index].mItems;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Hat Draw"),
        ),
        body: ItemsPageContent(catName: catName, catItems: itemList, ),
    );

  }
}

class ItemsPageContent extends StatefulWidget {
  ItemsPageContent({
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
    List<Widget> items = widget._catItems.map((i_name) => CategoryTileHolder(name: i_name, isChild: true,)).toList();
    items.add(CategoryTileHolder(name: "New Category", parentCat: widget._catName, isChild: true, isNew: true,));
    //items.add(CategoryTileHolder(name: "New Category", isChild: true, isNew: true,));

    return Column(
        children: [
          CategoryTile(name: widget._catName,),
            SizedBox(
                height: 600,
                width: 400,
                child:
                ListView(
                  //controller: widget.sController,
                  key: const Key("ItemList"),
                  padding: const EdgeInsets.all(16.0),
                  children: items,
                )
            ),
          DrawButton(items: context.watch<HdwState>().sCurrentItems),
        ]
    );
  }
}