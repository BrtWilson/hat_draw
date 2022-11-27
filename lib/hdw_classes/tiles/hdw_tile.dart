import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_classes/hdw_constants.dart';

import '../tiles/category_tile.dart';
import '../tiles/current_selection_tile.dart';
import 'new_category_tile.dart';

class HdwTile extends StatelessWidget {
  const HdwTile({
    Key? key,
    required String name,
    String parent = "",
    bool isChild = false,
    bool isNew = false,
  })
    : _name = name,
      _parent = parent,
      _isChild = isChild,
      _isNew = isNew,
      super(key: key);

  final String _name;
  final String _parent;
  final bool _isChild;
  final bool _isNew;

  @override
  Widget build(BuildContext context) {
    Widget bTile;
    double bWidth = MediaQuery.of(context).size.width;
    double bWidthRedux = ((_isChild) ? 30 : 0);

    if (_name == HdwConstants.currentSelection) {
      bTile = const CurrentSelectionTile();
    }
    else if (_isNew) {
      bTile = NewCategoryTile(name: _name, parentCat: _parent, isChild: _isChild,);
    }
    else {
      bTile = CategoryTile(name: _name, parentCat: _parent, isChild: _isChild, isNew: _isNew,);
    }

    return SizedBox(
      height: 50,
      width: bWidth,
      child: Card(
        margin: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 5.0,),
        child: SizedBox(
          height: HdwConstants.tileHeight,
          width: bWidth - bWidthRedux,
          child: bTile
        ),
      ),
    );
  }


}