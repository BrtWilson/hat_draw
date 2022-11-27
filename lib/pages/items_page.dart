import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_classes/tiles/hdw_tile.dart';
import 'package:hat_draw_app/hdw_constants.dart';
import 'package:provider/provider.dart';
import 'package:hat_draw_app/hdw_classes/draw_button.dart';
import 'package:hat_draw_app/hdw_state.dart';

import '../hdw_classes/hdw_title_bar.dart';

class ItemsPage extends StatelessWidget {
  ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Map;
    String catName = arg[HdwConstants.catArg];
    List<String> itemList;
    if (catName == HdwConstants.currentSelection) {
      itemList = context.watch<HdwState>().sCurrentItems;
    }
    else {
      int index = context.watch<HdwState>().sCategories.indexOf(catName);
      itemList = context.watch<HdwState>().sCatContents[index].mItems;
    }

    return Scaffold(
        appBar: AppBar(
          title: const HdwTitleBar(),
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
    List<Widget> items = widget._catItems.map((i_name) => HdwTile(name: i_name, isChild: true,)).toList();
    items.add(HdwTile(name: "New Item", parent: widget._catName, isChild: true, isNew: true,));

    double keyOverflow = 0.0;
    if (MediaQuery.of(context).viewInsets.bottom != 0) keyOverflow = 208.0;

    return
      SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child:
          Column(
            children: [
              HdwTile(name: widget._catName,),
              SizedBox(
                height: 600 - keyOverflow,
                width: 400,
                child:
                  ListView(
                    //controller: widget.sController,
                  key: const Key("ItemList"),
                  padding: const EdgeInsets.all(16.0),
                  children: items,
                ),
              ),
              if (keyOverflow == 0.0) DrawButton(items: context.watch<HdwState>().sCurrentItems),
            ]
          )
      );
  }
}