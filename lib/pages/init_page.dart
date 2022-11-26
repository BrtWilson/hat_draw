import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_state.dart';
import 'package:provider/provider.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Map;
    List<String> itemsList = arg['itemsList'];
    var selection = "Whoops! Nothing.";
    if (itemsList.isNotEmpty) {
      final rand = Random();
      int index = rand.nextInt(itemsList.length);
      selection = itemsList[index];
    }


    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text("Hat Draw"),
              Image.asset('assets/tophat_icon.png'),
            ],
          )
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
                    Image.asset('assets/hat_draw_large.png'),
                    FloatingActionButton.extended(
                      label: const Text("Prepare a Draw"),
                      backgroundColor: Colors.red[900],
                      foregroundColor: Colors.black,
                      onPressed: () => {
                        Navigator.pushNamed(context, '/categories',)
                      },
                    ),
                    FloatingActionButton.extended(
                      label: const Text("Repeat last Draw"),
                      backgroundColor: Colors.red[900],
                      foregroundColor: Colors.black,
                      // backgroundColor: Colors.blue[800],
                      // foregroundColor: Colors.white,
                      onPressed: () => {
                        Navigator.pushNamed(context, "/draw", arguments: {'itemsList': context.watch<HdwState>().sCurrentItems } )
                      },
                    ),
                  ],
              ),
            ),
          ],
        ),
    );
  }
}