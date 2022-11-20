import 'package:flutter/material.dart';
import 'package:hat_draw_app/new_category_tile.dart';

import 'category_tile.dart';

class CategoryTileHolder extends StatelessWidget {
  CategoryTileHolder({
    Key? key,
    required String name,
    String parentCat = "",
    bool isChild = false,
    bool isNew = false,
  })
      : _name = name,
        _parent = parentCat,
        _isChild = isChild,
        _isNew = isNew,
        super(key: key);

  final String _name;
  final String _parent;
  bool _isChild;
  final bool _isNew;


  @override
  Widget build(BuildContext context) {
    if (_isNew) {
      return NewCategoryTile(name: _name, parentCat: _parent, isChild: _isChild,);
    }
    else {
      return CategoryTile(name: _name, parentCat: _parent, isChild: _isChild, isNew: _isNew,);
    }
  }
}