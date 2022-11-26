import 'package:flutter/material.dart';

class DrawButton extends StatelessWidget {
  const DrawButton({
    Key? key,
    required List<String> items,
    bool is_redraw = false,
  }) : _items = items, _isRedraw = is_redraw, super(key: key);

  final List<String> _items;
  final bool _isRedraw;

  @override
  Widget build(BuildContext context) {
    String buttonText = (_isRedraw) ? "Re-Draw!  ": "Draw!  ";
    return Align(
      alignment: Alignment.bottomCenter,
      child:
        FloatingActionButton.extended(
          heroTag: "draw",
          label: Row(
            children: [
              Text(buttonText),
              const Icon(
                Icons.breakfast_dining_sharp
              ),
            ]
          ),
          backgroundColor: Colors.red[800],
          foregroundColor: Colors.black,
          onPressed: () => {
//            if (_items.isNotEmpty) {
              if (_isRedraw) Navigator.pushReplacementNamed(context, "/draw", arguments: {'itemsList': _items } )
              else Navigator.pushNamed(context, "/draw", arguments: {'itemsList': _items } )
//            }
          },
        ),
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