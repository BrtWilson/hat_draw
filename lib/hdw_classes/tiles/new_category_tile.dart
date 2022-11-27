import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_classes/tiles/category_tile.dart';
import 'package:provider/provider.dart';
import 'package:hat_draw_app/hdw_state.dart';

class NewCategoryTile extends CategoryTile {
  NewCategoryTile({
    Key? key,
    required String name,
    bool isChild = false,
    String parentCat = "",
  })
      : _name = name,
        _isChild = isChild,
        _parent = parentCat,
        super(key: key, name: name);

  final String _name;
  final bool _isChild;
  final String _parent;
  final TextEditingController _teController = TextEditingController();

  @override
  State<NewCategoryTile> createState() => _NewCategoryTileState();
}

class _NewCategoryTileState extends State<NewCategoryTile> {

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          if (widget._isChild) const Spacer(),
          Card(
            margin: const EdgeInsets.fromLTRB(16.0,10.0,16.0,5.0),
            child:
                SizedBox(
                  width: 347 - ((widget._isChild) ? 30 : 0),
                  child:
                    Row(
                      children: [
                        if (widget._isChild) const Spacer(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child:
                          Container(
                            width: 270 - ((widget._isChild) ? 30 : 0),
                            color: Colors.grey[300],
                            child:
                            TextField(
                              controller: widget._teController,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[600],
                              ),
                              decoration: InputDecoration(
                                hintText: widget._name,
                              ),
                              // onEditingComplete: instead**
                              // onSubmitted: () {
                              //   String inputText = widget._teController.text;
                              //   setState(() {
                              //     if (widget._isChild) {
                              //       if (widget._parent.isNotEmpty) {
                              //         Provider.of<HdwState>(context, listen: false).addItem(widget._parent, inputText);
                              //         Navigator.pushReplacementNamed(context, '/items', arguments: { 'catName': widget._parent });
                              //       }
                              //       else {
                              //         print("Error with new item addition.");
                              //         var snackBar = const SnackBar(content: Text("Error with new item addition."));
                              //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              //       }
                              //     }
                              //     else {
                              //       Provider.of<HdwState>(context, listen: false).addCategory(inputText);
                              //     }
                              //   });
                              // }
                              // onTap: () => {
                              //   if (widget._isChild) Navigator.pushReplacementNamed(context, 'items', arguments: { 'catName': widget._parent }),
                              // },
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
                              ]
                          ),
                        ),
                        const Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.white,
                        ),
                        const Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.white,
                        ),
                      ],
                    ),
                )
          )
        ]
    );
  }
}



/*
icons list:
material icons class:
  mode_edit
  mode_edit_outline_outlined
  navigate_before (<)
  navigate_next (>)
  noise_aware
  not_started
  offline_pin     *
  outbond         *
  breakfast_dining_sharp    (<- use this for draw)
  sensor_window
  settings
  shortcut
  threesixty
  toggle_off / toggle_on
  upload_file
  vertical_align_bottom
  watch_later
  menu
  check_box_outline / check_box_outline_blank
  browse_gallery / browse_galler_outlined   (<- use for history)

 */
