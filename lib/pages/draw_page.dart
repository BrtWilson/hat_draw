import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_classes/draw_button.dart';
import 'package:hat_draw_app/hdw_constants.dart';

class DrawPage extends StatelessWidget {
  const DrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Map;
    List<String> itemsList = arg[HdwConstants.clistArg];
    var selection = "Whoops! Nothing.";
    if (itemsList.isNotEmpty) {
      final rand = Random();
      int index = rand.nextInt(itemsList.length);
      selection = itemsList[index];
    }


    return Scaffold(
        appBar: AppBar(
          title: const Text("Hat Draw"),
        ),
        body: Column(
          children: [
            const Spacer(),
            Text(selection),
            const Image(
              image: AssetImage('assets/hat_draw_large.png'),
              height: 320,
              width: 380,
            ),
            const Spacer(),
            SizedBox(
              height: 100,
              child: Column(
                  children: [
                    DrawButton(items: itemsList, is_redraw: true),
                    const Spacer(),
                    FloatingActionButton.extended(
                      label: const Text("Return to Selection"),
                      backgroundColor: Colors.red[900],
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