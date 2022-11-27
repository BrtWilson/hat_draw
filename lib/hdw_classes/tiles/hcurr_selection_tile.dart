import 'package:flutter/material.dart';
import 'package:hat_draw_app/hdw_constants.dart';

class HCurrSelectionTile extends StatelessWidget {
  const HCurrSelectionTile({super.key,});

  final String _name = HdwConstants.currentSelection;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child:
            Container(
              alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width,
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