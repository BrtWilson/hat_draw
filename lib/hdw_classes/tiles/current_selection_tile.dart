import 'package:flutter/material.dart';

class CurrentSelectionTile extends StatelessWidget {
  const CurrentSelectionTile({super.key,});

  final String name_ = " Current Selection ";

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(16.0,10.0,16.0,5.0),
            child:
            Row(
              children: [
                InkWell(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 270,
                    // todo: see if adding height: 20, helps with pressing
                    child:
                    Text(
                        name_,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[600]
                        )
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/items', arguments: { 'catName': name_ });
                  }
                ),
              ],
            ),
          )
        ]
    );
  }}


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