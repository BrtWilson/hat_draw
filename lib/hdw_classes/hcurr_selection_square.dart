import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_constants.dart';
import 'package:hat_draw_app/hdw_state.dart';

class HCurrSelectionSquare extends StatelessWidget {
  const HCurrSelectionSquare({super.key,});

  final String _name = HdwConstants.currentSelection;

  @override
  Widget build(BuildContext context) {
    double textWidth = HdwConstants.stdTextWidth(context) / 2;
    double contWidth = textWidth + 30;
    int itemCount = HdwState().itemCount();

    return
      InkWell(
        child:
          Container(
            width: contWidth,
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey)
            ),
            child: Column(
              children: [
                Card(
                  child: Text(_name),
                ),
                Text(
                   "$itemCount items",
                ),
              ]
            )
          ),
        onTap:  () {
            Navigator.pushNamed(context, HdwConstants.itemsPage, arguments:  { HdwConstants.catArg : _name });
          },
      );

    //   Row(
    //   children: [
    //     InkWell(
    //       child:
    //         Container(
    //           alignment: Alignment.centerLeft,
    //           width: textWidth,
    //           child:
    //             Text(
    //               _name,
    //               style: TextStyle(
    //                 fontSize: HdwConstants.fontSize,
    //                 color: Colors.grey[600],
    //               ),
    //             ),
    //         ),
    //       onTap: () {
    //         Navigator.pushNamed(context, HdwConstants.itemsPage, arguments:  { HdwConstants.catArg : _name });
    //       },
    //     ),
    //   ],
    // );
  }


}