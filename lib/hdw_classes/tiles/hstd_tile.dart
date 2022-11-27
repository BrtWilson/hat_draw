

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_classes/hdw_constants.dart';
import 'package:provider/provider.dart';

import '../../hdw_state.dart';

class HStdTile extends StatefulWidget {
  HStdTile({
    Key? key,
    required String name,
    String parent = "",
    bool isChild = false,
  })
      : _name = name,
        _parent = parent,
        _isChild = isChild,
        super(key: key);

  final String _name;
  final String _parent;
  final bool _isChild;
  bool _isEditing = false;

  @override
  State<StatefulWidget> createState() => StdTileState();
}

class StdTileState extends State<HStdTile> {
  void TileEdit(bool set) {
    setState(() {
      widget._isEditing = set;
      //todo: check
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget._isEditing) {
      return StdTileEditing(name: widget._name,  isChild: widget._isChild, edit: TileEdit);
    }
    else {
      return StdTileStatic(name: widget._name, isChild: widget._isChild, edit: TileEdit);
    }
  }
}

class StdTileStatic extends StatelessWidget {
  /*
  /Card(
    checkbox
    text
    edit
  /)
   */
  StdTileStatic({
    Key? key,
    required String name,
    required edit,
    String parentCat = "",
    bool isChild = false,
  })
      : _name = name,
        Edit_ = edit,
        _parent = parentCat,
        _isChild = isChild,
        super(key: key);

  final String _name;
  final String _parent;
  final bool _isChild;
  bool _isChecked = false;
  final Function Edit_;


  @override
  Widget build(BuildContext context) {
    double nonClickableWidth = 50.0;
    if (_isChild) nonClickableWidth += HdwConstants.tileWidthRedux;
    double clickableWidth = MediaQuery.of(context).size.width - nonClickableWidth;

    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            if (value != null) {
              _isChecked = value;
              if (_isChild) {
                Provider.of<HdwState>(context, listen: false).setItemInclusion(_name, value);
              }
              else {
                Provider.of<HdwState>(context, listen: false).setCategoryInclusion(_name, value);
              }
            }
          },
        ),
        InkWell(
          child: Container(
            alignment: Alignment.centerLeft,
            width: clickableWidth,
            height: HdwConstants.tileHeight,
            child:
            Text(
                " $_name ",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[600]
                )
            ),
          ),
          onTap: () {
            if (!(_isChild)) {
              if (ModalRoute.of(context)?.settings.name != HdwConstants.itemsPage) {
                Navigator.pushNamed(context, HdwConstants.itemsPage, arguments: { 'catName': _name });
              }
            }
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Row (
            children: [
              InkWell(
                  child: Icon(
                    Icons.edit,
                    color: Colors.grey[700],
                    size: 25.0,
                  ),
                  onTap: () {
                    Edit_(true);
                    // todo: test edit capability later
                    // consider adding a delete option while editing **
                  }
              ),
            ]
          ),
        ),
      ],
    );
  }
}

class StdTileEditing extends StatelessWidget{
  StdTileEditing({
    Key? key,
    required String name,
    required edit,
    String parentCat = "",
    bool isChild = false,
  })
      : _name = name,
        Edit_ = edit,
        _parent = parentCat,
        _isChild = isChild,
        super(key: key);

  final String _name;
  final String _parent;
  final bool _isChild;
  bool _isChecked = false;
  final Function Edit_;
  final TextEditingController _teController = TextEditingController();

  /*
  /Card(
    greyed checkbox
    editable text
    edit (
      save
      delete
    )
  /)
   */

  @override
  Widget build(BuildContext context) {
    _teController.text = _name;
    double nonClickableWidth = 50.0;
    if (_isChild) nonClickableWidth += HdwConstants.tileWidthRedux;
    double clickableWidth = MediaQuery.of(context).size.width - nonClickableWidth;

    if (_isChild) {
      _isChecked = context.watch<HdwState>().sCurrentItems.contains(_name);
    }
    else {
      _isChecked = context.watch<HdwState>().checkForCategory(_name);
    }

    return Row(
      children: [
        if (_isChecked)
          Icon(
            Icons.check_box_outlined,
            color: Colors.grey[800],
            size: 25.0,
          )
        else
          Icon(
            Icons.check_box_outline_blank,
            color: Colors.grey[800],
            size: 25.0,
          ),
        InkWell(
          child: Container(
            alignment: Alignment.centerLeft,
            width: clickableWidth,
            height: HdwConstants.tileHeight,
            child:
              TextField(
                controller: _teController,
                style: TextStyle(
                  fontSize: HdwConstants.fontSize,
                  color: Colors.grey[600],
                ),
                decoration: InputDecoration(
                  hintText: _name,
                ),
              ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Row (
            children: [
              InkWell(
                  child: Icon(
                    Icons.add,
                    color: Colors.grey[700],
                    size: 25.0,
                  ),
                  onTap: () {
                    Edit_(true);
                    // todo: test edit capability later
                    // consider adding a delete option while editing **
                  }
              ),
              InkWell(
                  child: Icon(
                    Icons.remove,
                    color: Colors.grey[700],
                    size: 25.0,
                  ),
                  onTap: () {
                    Edit_(true);
                    // todo: test edit capability later
                    // consider adding a delete option while editing **
                  }
              ),
            ]
          ),
        ),
      ],
    );
  }
}

/*
select all:
  checkmark circle?
  add_to_photos
select all here:
  playlist_add
clear all:
  eraser
  broom
  playlist_remove
 */