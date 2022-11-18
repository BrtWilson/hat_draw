import 'package:flutter/material.dart';

class HdwWideButton extends StatelessWidget {
  const HdwWideButton({
    Key? key,
    required String buttontext,
    required Function action,
  }) : _buttontext = buttontext, _action = action, super(key: key);

  final String _buttontext;
  final Function _action;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(_buttontext),
      backgroundColor: Colors.blue[800],
      foregroundColor: Colors.white,
      onPressed: () => { _action },
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