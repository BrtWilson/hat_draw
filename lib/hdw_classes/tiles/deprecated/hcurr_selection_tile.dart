import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_constants.dart';

class HCurrSelectionTile extends StatelessWidget {
  const HCurrSelectionTile({super.key,});

  final String _name = HdwConstants.currentSelection;

  @override
  Widget build(BuildContext context) {
    double textWidth = HdwConstants.stdTextWidth(context);

    return Row(
      children: [
        InkWell(
          child:
            Container(
              alignment: Alignment.centerLeft,
              width: textWidth,
              child:
                Text(
                  _name,
                  style: TextStyle(
                    fontSize: HdwConstants.fontSize,
                    color: Colors.grey[600],
                  ),
                ),
            ),
          onTap: () {
            Navigator.pushNamed(context, HdwConstants.itemsPage, arguments:  { HdwConstants.catArg : _name });
          },
        ),
      ],
    );
  }


}