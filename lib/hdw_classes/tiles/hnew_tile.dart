import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_constants.dart';
import 'package:provider/provider.dart';

import '../../hdw_state.dart';

class HNewTile extends StatefulWidget {
  HNewTile({
    Key? key,
    required String name,
    bool isChild = false,
    String parent = "",
  })
      : _name = name,
        _isChild = isChild,
        _parent = parent,
        super(key: key);

  final String _name;
  final bool _isChild;
  final String _parent;
  final TextEditingController _teController = TextEditingController();

  @override
  State<StatefulWidget> createState() => NewTileState();
}

class NewTileState extends State<HNewTile> {
  @override
  Widget build(BuildContext context) {
    double nonClickableWidth = 90.0;
    if (widget._isChild) nonClickableWidth += HdwConstants.tileWidthRedux;
    double clickableWidth = MediaQuery.of(context).size.width - nonClickableWidth;

    return Row(
      children: [
        Container(
          width: clickableWidth,
          color: Colors.grey[300],
          child:
            TextField(
              controller: widget._teController,
              style: TextStyle(
                fontSize: HdwConstants.fontSize,
                color: Colors.grey[600],
              ),
              decoration: InputDecoration(
                hintText: widget._name,
              ),
            ),
        ),
        InkWell(
            child: Icon(
              Icons.add,
              color: Colors.grey[700],
              size: 25.0,
            ),
            onTap: () {
              String inputText = widget._teController.text;
              setState(() {
                if (widget._isChild) {
                  if (widget._parent.isNotEmpty) {
                    Provider.of<HdwState>(context, listen: false).addItem(widget._parent, inputText);
                    Navigator.pushReplacementNamed(context, '/items', arguments: { 'catName': widget._parent });
                  }
                  else {
                    print("Error with new item addition.");
                    var snackBar = const SnackBar(content: Text("Error with new item addition."));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
                else {
                  Provider.of<HdwState>(context, listen: false).addCategory(inputText);
                }
              });
            }
        ),
      ],
    );
  }
}