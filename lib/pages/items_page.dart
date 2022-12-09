import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_classes/hdw_page_footer.dart';
import 'package:hat_draw_app/hdw_classes/tiles/hdw_tile.dart';
import 'package:hat_draw_app/hdw_constants.dart';
import 'package:provider/provider.dart';
import 'package:hat_draw_app/hdw_classes/draw_button.dart';
import 'package:hat_draw_app/hdw_state.dart';

import '../hdw_classes/hdw_title_bar.dart';

class ItemPageConstants {
  static const String clearSelection = "clear selection";
  static const String addCategory = "add";
  static const String removeCategory = "remove category";
}


class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

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

  void Action(String action) {
    setState(() {
      if (ItemPageConstants.addCategory == action) {
        Provider.of<HdwState>(context, listen: false).setCategoryInclusion(widget._catName, true);
      }
      else if (ItemPageConstants.removeCategory == action) {
        Provider.of<HdwState>(context, listen: false).setCategoryInclusion(widget._catName, false);
      }
      else if (ItemPageConstants.clearSelection == action) {
        Provider.of<HdwState>(context, listen: false).clearSelection();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = widget._catItems.map((i_name) => HdwTile(name: i_name, parent: widget._catName, isChild: true,)).toList();
    items.add(HdwTile(name: "New Item", parent: widget._catName, isChild: true, isNew: true,));

    double keyOverflow = 0.0;
    if (MediaQuery.of(context).viewInsets.bottom != 0) keyOverflow = 208.0;

    return
      SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child:
          Column(
            children: [
              //HdwTile(name: widget._catName,),
              ItemsPageBar(catName: widget._catName, update: Action),
              SizedBox(
                height: 550 - keyOverflow,
                width: 400,
                child:
                  ListView(
                    //controller: widget.sController,
                  key: const Key("ItemList"),
                  padding: const EdgeInsets.all(16.0),
                  children: items,
                ),
              ),
              if (keyOverflow == 0.0) HdwPageFooter(), //DrawButton(items: context.watch<HdwState>().sCurrentItems),
            ]
          )
      );
  }
}


class ItemsPageBar extends StatelessWidget {
  const ItemsPageBar({
    Key? key,
    required String catName,
    required update,
  })
      : _catName = catName,
        Action_ = update,
        super(key: key);

  final String _catName;
  final Function Action_;

  @override
  Widget build(BuildContext context) {
    double iconsWidth = 60;

    return Container(
      width: HdwConstants.stdTileWidth(context),
      height: HdwConstants.tileHeight,
      color: Colors.red[700],
      child: Row(
        children: [
          Text(
              " $_catName ",
              style: const TextStyle(
                  fontSize: HdwConstants.fontSize + 2.0,
                  color: Colors.black
              )
          ),
          const Spacer(flex: 4,),
          SizedBox(
            width: iconsWidth,
//            color: Colors.white38,
            child: Row(
              children: [
                if (HdwConstants.currentSelection != _catName)
                  InkWell(
                    child:
                      Container(
                        color: Colors.white38,
                        child:
                          Icon(
                            Icons.playlist_add,
                            color: Colors.green[800],
                            size: 25.0,
                          ),
                      ),
                    onTap: () {
                      Action_(ItemPageConstants.addCategory);
                    },
                    onLongPress: () {

                    },
                  ),
                const Spacer(),
                if (HdwConstants.currentSelection != _catName)
                  InkWell(
                    child:
                    Container(
                      color: Colors.white38,
                      child: Icon(
                        Icons.playlist_remove,
                        color: Colors.red[800],
                        size: 25.0,
                      ),
                    ),
                    onTap: () {
                      Action_(ItemPageConstants.removeCategory);
                    },
                    onLongPress: () {

                    },
                  ),
                if (HdwConstants.currentSelection == _catName)
                  InkWell(
                    child:
                      Container(
                      color: Colors.white38,
                      child:
                        const Icon(
                          Icons.delete_sweep_outlined,
                          color: Colors.black,
                          size: 25.0,
                        ),
                      ),
                    onTap: () {
                      Action_(ItemPageConstants.clearSelection);
                    },
                    onLongPress: () {

                    },
                  ),
              ],
            ),
          ),
          const Spacer(),
        ]
      ),
    );
  }

}