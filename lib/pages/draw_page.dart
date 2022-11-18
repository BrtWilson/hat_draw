import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hat_draw_app/hdw_classes/category_tile.dart';
import 'package:hat_draw_app/hdw_classes/draw_button.dart';
import 'package:hat_draw_app/hdw_classes/hdw_wide_button.dart';
import 'package:hat_draw_app/hdw_state.dart';
import 'package:hat_draw_app/pages/items_page.dart';

class DrawPage extends StatelessWidget {
  DrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    List<String> _itemsList = arg['itemsList'];
    final _rand = Random();
    var _selection = _itemsList[_rand.nextInt(_itemsList.length)];

    return Scaffold(
        appBar: AppBar(
          title: Text("Hat Draw"),
        ),
        body: Column(
          children: [
            Spacer(),
            Text(_selection),
            Spacer(),
            Container(
              height: 100,
              child: Column(
                  children: [
                    DrawButton(items: _itemsList, is_redraw: true),
                    FloatingActionButton.extended(
                      label: const Text("Return to Selection"),
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white,
                      onPressed: () => { Navigator.pop(context) },
                    ),
                    // HdwWideButton(buttontext: "Return to Selection", action: () {
                    //   Navigator.pushNamed(context, "/categories");
                    //   //Navigator.pop(context);
                    // })
                  ],
              ),
            ),
          ],
        ),
    );
  }
}