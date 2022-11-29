import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_constants.dart';
import 'package:provider/provider.dart';

import '../../hdw_state.dart';

class StdTileConstants {
  static const String delete = "delete";
  static const String add = "add";
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
    setState(() {
      if (StdTileConstants.cancel != action) {
        if (StdTileConstants.add == action) {
          String newText = teController.text;
          if (!Provider.of<HdwState>(context, listen: false).editItem(
              widget._parent, widget._name, newText)) {
            print("FAILURE: Item not found");
          }
          else
            print("Edited item");
        }
        else if (StdTileConstants.delete == action) {
          if (!Provider.of<HdwState>(context, listen: false).removeItem(
              widget._parent, widget._name)) {
            print("FAILURE: Item not found");
          }
          else
            print("Deleted item");
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
        Provider.of<HdwState>(context, listen: false).setItemInclusion(widget._name, value);
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
        Update_ = update,
        _isChild = isChild,
        super(key: key);

  final String _name;
  final bool _isChild;
  bool _isChecked = false;
  final Function Edit_;
  final Function Update_;


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
            Update_(value);
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
              Action_(StdTileConstants.delete, _teController); // Todo: verify
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
                  Icons.add,
                  color: Colors.grey[700],
                  size: 25.0,
                ),
                onTap: () {
                  // String newText = _teController.text;
                  // Provider.of<HdwState>(context, listen: false).editItem(
                  //     _parent, _name, newText);
                  Action_(StdTileConstants.add, _teController); // TODO: ** not functioning...
                },
              ),
              InkWell(
                  child: Icon(
                    Icons.cancel_outlined,
                    color: Colors.grey[700],
                    size: 25.0,
                  ),
                  onTap: () {
                  //   String newText = _teController.text;
                  //   Provider.of<HdwState>(context, listen: false).editItem(
                  //       _parent, _name, newText);
                    Action_(StdTileConstants.cancel, _teController); // TODO: ** not functioning...
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