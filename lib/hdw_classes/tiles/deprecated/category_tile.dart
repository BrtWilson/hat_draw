import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hat_draw_app/hdw_state.dart';

class CategoryTile extends StatefulWidget {
  CategoryTile({
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
  final bool _isChild;
  final bool _isNew;

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {

//     if (widget._isNew) {
//       if (widget._isChild) {
// //        return NewCategoryTile(name: widget._name,);
//         return NewCategoryTile(name: widget._name, isChild: true, parentCat: widget._parent,);
//       } else {
//         return NewCategoryTile(name: widget._name,);
//       }
//     }
//     else {
      if (widget._isChild) {
        isChecked = context.watch<HdwState>().sCurrentItems.contains(widget._name);
      }
      else {
        isChecked = context.watch<HdwState>().checkForCategory(widget._name);
      }

      return
        Container(
          child:
            Row(
              children: [
                if (widget._isChild) const Spacer(),
                Card(
                  margin: const EdgeInsets.fromLTRB(16.0,10.0,16.0,5.0),
                  child:
                    SizedBox(
                      width: 343 - ((widget._isChild) ? 30 : 0),
                      height: 50,
                      child: Row(
                        children: [
                          const Spacer(),
                          InkWell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: 270 - ((widget._isChild) ? 30 : 0),
                              // to-do: see if adding height: 20, helps with pressing
                              child:
                              Text(
                                  " ${widget._name} ",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.grey[600]
                                  )
                              ),
                            ),
                            onTap: () {
                              if (!(widget._isChild)) {
                                if (ModalRoute.of(context)?.settings.name != '/items') {
                                  Navigator.pushNamed(context, '/items', arguments: { 'catName': widget._name });
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
                                        // to-do: add edit capability later
                                        // consider adding a delete option while editing **
                                      }
                                  ),
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value != null) {
                                          isChecked = value;
                                          if (widget._isChild) {
                                            Provider.of<HdwState>(context, listen: false).setItemInclusion(widget._name, value);
                                            //context.watch<HdwState>().setItemInclusion(widget._name, value);
                                          }
                                          else {
                                            // List<String> catItems = Provider.of<HdwState>(context, listen: false).getItems(widget._name);
                                            // for (var item in catItems) {
                                            //   Provider.of<HdwState>(context, listen: false).setItemInclusion(item, value);
                                            //   //context.watch<HdwState>().setItemInclusion(item, value);
                                            // }
                                            Provider.of<HdwState>(context, listen: false).setCategoryInclusion(widget._name, value);
                                          }
                                        }
                                        if (!widget._isChild) {
                                          setState(() {

                                          });
                                          //                                Navigator.pushReplacementNamed(context, '/items', arguments: { 'catName': widget._name });
                                          //Navigate is problematic when on category page
                                        }
                                      });
                                    },
                                  ),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),

                ),
              ]
            ),
          // },
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