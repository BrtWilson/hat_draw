import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_constants.dart';
import 'package:provider/provider.dart';

import '../../hdw_state.dart';

class StdTileConstants {
  static const String delete = "delete";
  static const String edit = "edit";
  static const String cancel = "cancel";
}


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
    });
  }

  void ItemUpdate(String action, TextEditingController teController) {
    final bool notifyingPage = (HdwConstants.currentSelection == widget._parent);
    setState(() {
      if (StdTileConstants.cancel != action) {
        if (StdTileConstants.edit == action) {
          String newText = teController.text;
          bool success = false;
          if (widget._isChild) {
            success = Provider.of<HdwState>(context, listen: false).editItem(
                widget._parent, widget._name, newText, notifyingPage);
          }
          else {
            Provider.of<HdwState>(context, listen: false).editCategory(
                widget._parent, newText);
          }
          if (!success) print("Failed to edit item.");
        }
        else if (StdTileConstants.delete == action) {
          bool success = false;
          if (!notifyingPage) {
            Provider.of<HdwState>(context, listen: false).setItemInclusion(widget._name, false, true);
          }
          else if (widget._isChild) {
            success = Provider.of<HdwState>(context, listen: false).removeItem(
                widget._parent, widget._name);
          }
          else {
            // TODO: correct to account for <item vs category> (only allowing if category is empty, or after verification)
            print("Category Deletion not implemented");
          }
          if (!success) print("Failed to delete item.");
        }
        if (widget._isChild) {
          Navigator.pushReplacementNamed(context, HdwConstants.itemsPage,
              arguments: { HdwConstants.catArg: widget._parent});
        }
      }
      widget._isEditing = false;
    });
  }

  void Checkbox(bool value) {
    setState(() {
      if (widget._isChild) {
        bool notifying = (HdwConstants.currentSelection == widget._name);
        Provider.of<HdwState>(context, listen: false).setItemInclusion(widget._name, value, notifying);
      }
      else {
        Provider.of<HdwState>(context, listen: false).setCategoryInclusion(widget._name, value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget._isEditing) {
      return StdTileEditing(name: widget._name, parentCat: widget._parent,  isChild: widget._isChild, edit: TileEdit, update: ItemUpdate,);
    }
    else {
      return StdTileStatic(name: widget._name, isChild: widget._isChild, edit: TileEdit, update: Checkbox,);
    }
  }
}

class StdTileStatic extends StatelessWidget {
  StdTileStatic({
    Key? key,
    required String name,
    required edit,
    required update,
    bool isChild = false,
  })
      : _name = name,
        Edit_ = edit,
        CBUpdate_ = update,
        _isChild = isChild,
        super(key: key);

  final String _name;
  final bool _isChild;
  bool _isChecked = false;
  final Function Edit_;
  final Function CBUpdate_;


  @override
  Widget build(BuildContext context) {
    double textWidth = HdwConstants.stdTextWidth(context);
    if (_isChild) {
      textWidth -= 10.0;
      _isChecked = context.watch<HdwState>().sCurrentItems.contains(_name);
    }
    else {
      _isChecked = context.watch<HdwState>().checkForCategory(_name);
    }

    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            _isChecked = value!;
            CBUpdate_(value);
          },
        ),
        InkWell(
          child: Container(
            alignment: Alignment.centerLeft,
            width: textWidth,
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
                Navigator.pushNamed(context, HdwConstants.itemsPage, arguments: { HdwConstants.catArg: _name });
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
    required update,
    String parentCat = "",
    bool isChild = false,
  })
      : _name = name,
        Edit_ = edit,
        Action_ = update,
        _parent = parentCat,
        _isChild = isChild,
        super(key: key);

  final String _name;
  final String _parent;
  final bool _isChild;
  bool _isChecked = false;
  final Function Edit_;
  final Function Action_;
  final TextEditingController _teController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _teController.text = _name;
    // double nonClickableWidth = 50.0;
    // if (_isChild) nonClickableWidth += HdwConstants.tileWidthRedux;
    // double clickableWidth = MediaQuery.of(context).size.width - nonClickableWidth;
    double textWidth = HdwConstants.stdTextWidth(context);
    if (_isChild) {
      _isChecked = context.watch<HdwState>().sCurrentItems.contains(_name);
      textWidth -= 11.0;
    }
    else {
      _isChecked = context.watch<HdwState>().checkForCategory(_name);
    }

    return Row(
      children: [
        InkWell(
            child: Icon(
              Icons.delete,
              color: Colors.grey[700],
              size: 25.0,
            ),
            onTap: () {
              _teController.text = "";
              // Provider.of<HdwState>(context, listen: false).removeItem(_parent, _name);
              Action_(StdTileConstants.delete, _teController);
            }
        ),
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
            width: textWidth - 30,
            height: HdwConstants.tileHeight,
            color: Colors.grey[300],
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
                  Icons.check,
                  color: Colors.grey[700],
                  size: 25.0,
                ),
                onTap: () {
                  // String newText = _teController.text;
                  // Provider.of<HdwState>(context, listen: false).editItem(
                  //     _parent, _name, newText);
                  Action_(StdTileConstants.edit, _teController);
                  //TODO:  differentiate category and item editing.
                },
              ),
              InkWell(
                  child: Icon(
                    Icons.close,
                    color: Colors.grey[700],
                    size: 25.0,
                  ),
                  onTap: () {
                  //   String newText = _teController.text;
                  //   Provider.of<HdwState>(context, listen: false).editItem(
                  //       _parent, _name, newText);
                    Action_(StdTileConstants.cancel, _teController);
                  },
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