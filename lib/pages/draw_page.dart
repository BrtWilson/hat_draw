import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_classes/draw_button.dart';

class DrawPage extends StatelessWidget {
  DrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Map;
    List<String> itemsList = arg['itemsList'];
    final rand = Random();
    var selection = itemsList[rand.nextInt(itemsList.length)];


    return Scaffold(
        appBar: AppBar(
          title: const Text("Hat Draw"),
        ),
        body: Column(
          children: [
            Spacer(),
            Text(selection),
            Spacer(),
            Container(
              height: 100,
              child: Column(
                  children: [
                    DrawButton(items: itemsList, is_redraw: true),
                    FloatingActionButton.extended(
                      label: const Text("Return to Selection"),
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white,
                      onPressed: () => { Navigator.pop(context) },
                    ),
                  ],
              ),
            ),
          ],
        ),
    );
  }
}