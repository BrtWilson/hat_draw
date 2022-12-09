import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_constants.dart';
import 'package:hat_draw_app/hdw_state.dart';
import 'package:provider/provider.dart';

import '../hdw_classes/hdw_title_bar.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const HdwTitleBar(),
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
                  SizedBox(
                    height: 60,
                    child:
                      Column(
                        children: [
                          FloatingActionButton.extended(
                            heroTag: "prepare draw",
                            label: const Text("Prepare a Draw"),
                            backgroundColor: Colors.red[900],
                            foregroundColor: Colors.black,
                            onPressed: () => {
                              Provider.of<HdwState>(context, listen: false).clearSelection(),
                              Navigator.pushNamed(context, HdwConstants.categoriesPage,)
                            },
                          ),
                        ],
                      ),
                  ),
                  FloatingActionButton.extended(
                    heroTag: "init draw",
                    label: const Text("Repeat last Draw"),
                    backgroundColor: Colors.red[900],
                    foregroundColor: Colors.black,
                    onPressed: () => {
                      Navigator.pushNamed(context, HdwConstants.drawPage, arguments: { HdwConstants.clistArg: Provider.of<HdwState>(context, listen:false).sLastSelection } )
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