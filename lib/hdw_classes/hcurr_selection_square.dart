import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_constants.dart';
import 'package:hat_draw_app/hdw_state.dart';
import 'package:provider/provider.dart';

class HCurrSelectionSquare extends StatelessWidget {
  const HCurrSelectionSquare({super.key,});

  final String _name = HdwConstants.currentSelection;

  @override
  Widget build(BuildContext context) {
    double textWidth = HdwConstants.stdTextWidth(context) / 2;
    double contWidth = textWidth + 30;
    double contHeight = 92;
    int itemCount = Provider.of<HdwState>(context, listen: true).itemCount();

    return SizedBox(
            width: contWidth,
            height: contHeight,
            child: Card(
              color: Colors.red[100],
              child: InkWell(
                child: Column(
                  children: [
                    Expanded(
                    flex: 5,
                    child:
                    Row(
                      children: [
                        const Spacer(flex: 3,),
                        Expanded(
                          flex: 7,
                          child: Text(
                            _name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.edit,
                          color: Colors.grey[800],
                          size: 20.0,
                        ),
                        const Spacer(flex: 2,),
                      ]
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    indent: 20.0,
                    endIndent: 20.0,
                  ),
                  Expanded(
                    flex: 3,
                    child:
                    Text(
                      "$itemCount items",
                    ),
                  ),
                ]
              ),
              onTap:  () {
                Navigator.pushNamed(context, HdwConstants.itemsPage, arguments:  { HdwConstants.catArg : _name });
              },
            ),
          ),
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