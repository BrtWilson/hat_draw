import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_classes/tiles/deprecated/hcurr_selection_tile.dart';
import 'package:hat_draw_app/hdw_classes/tiles/hstd_tile.dart';
import 'package:hat_draw_app/hdw_constants.dart';
import 'hnew_tile.dart';

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
    // double nonClickableWidth = 90.0;
    // if (widget._isChild) nonClickableWidth += HdwConstants.tileWidthRedux;
    // double clickableWidth = MediaQuery.of(context).size.width - nonClickableWidth;

    double bWidth = HdwConstants.stdTileWidth(context);
    double bWidthRedux = ((_isChild) ? HdwConstants.tileWidthRedux : 0);

    if (_name == HdwConstants.currentSelection) {
      bTile = const HCurrSelectionTile();
    }
    else if (_isNew) {
      bTile = HNewTile(name: _name, parent: _parent, isChild: _isChild,);
    }
    else {
      bTile = HStdTile(name: _name, parent: _parent, isChild: _isChild,);
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