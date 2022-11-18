import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hat_draw_app/hdw_state.dart';
import 'package:hat_draw_app/new_category_tile.dart';

class CategoryTile extends StatefulWidget {
  const CategoryTile({
    Key? key,
    required String name,
    required List<String> checkedItems,
    required Function setInclusion,
    String parentCat = "",
    bool isNew = false,
  })
      : _name = name,
        _checkedItems = checkedItems,
        _setInclusion = setInclusion,
        _parent = parentCat,
        _isNew = isNew,
        super(key: key);

  final String _name;
  final List<String> _checkedItems;
  final Function _setInclusion;
  final String _parent;
  final bool _isNew;

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    bool isChild = (widget._parent.isEmpty) ? false : true;
    if (widget._isNew) {
      if (isChild) {
        return NewCategoryTile(name: widget._name, parentCat: widget._parent,);
      } else {
        return NewCategoryTile(name: widget._name,);
      }
    }
    else {
      return Row(
        children: [
          if (isChild) const Spacer(),
          Card(
            margin: const EdgeInsets.fromLTRB(16.0,10.0,16.0,5.0),
            child:
            Row(
              children: [
                InkWell(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 270 - ((isChild) ? 30 : 0),
                    child:
                    Text(
                        widget._name,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[600]
                        )
                    ),
                  ),
                  onTap: () {
                    if (!isChild) {
                      if (ModalRoute.of(context)?.settings.name != '/items') Navigator.pushNamed(context, '/items', arguments: { 'catName': widget._name });
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
                            // todo: add edit capability later
                          }
                        )
                        ,
                        Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                isChecked = value;
                                if (isChild) {
                                  Provider.of<HdwState>(context, listen: false).setItemInclusion(widget._name, value);
                                  //context.watch<HdwState>().setItemInclusion(widget._name, value);
                                }
                                else {
                                  List<String> catItems = Provider.of<HdwState>(context, listen: false).getItems(widget._name);
                                  for (var item in catItems) {
                                    Provider.of<HdwState>(context, listen: false).setItemInclusion(item, value);
                                    //context.watch<HdwState>().setItemInclusion(item, value);
                                  }
                                }
                                //widget._setInclusion(isChecked); // TODO: fix inclusion of checked items
                              }
                            });
                          },
                        ),
                      ]
                  ),
                ),

                // Text(widget._name),
                // const Icon(Icons.mode_edit),
                // Checkbox(
                //   value: isChecked,
                //   onChanged: (value) {
                //     setState(() {
                //       isChecked = value!;
                //       widget._setInclusion(isChecked);
                //     });
                //   },
                // ),

                // IconButton(onPressed: onPressed,
                //     icon: icon
                // )
                // if (checked) const Icon(Icons.check_box_outlined)
                // else const Icon(Icons.check_box_outline_blank)

              ],
            ),
          )
        ]
    );
    }
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