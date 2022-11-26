import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_state.dart';
import 'package:provider/provider.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: const [
              Text("Hat Draw"),
              Image(
                image: AssetImage('assets/tophat_icon.png'),
                height: 30,
                width: 30,
              ),
            ],
          )
        ),
        body: Column(
          children: [
            Container(
              height: 600,
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Spacer(),
                  const Image(
                    image: AssetImage('assets/hat_draw_large.png'),
                    height: 300,
                    width: 300,
                  ),
                  const Spacer(),
                  Container(
                    height: 60,
                    child:
                      Column(
                        children: [
                          FloatingActionButton.extended(
                            label: const Text("Prepare a Draw"),
                            backgroundColor: Colors.red[900],
                            foregroundColor: Colors.black,
                            onPressed: () => {
                              Navigator.pushNamed(context, '/categories',)
                            },
                          ),
                        ],
                      ),
                  ),
                  FloatingActionButton.extended(
                    label: const Text("Repeat last Draw"),
                    backgroundColor: Colors.red[900],
                    foregroundColor: Colors.black,
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