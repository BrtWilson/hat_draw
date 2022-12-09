import 'package:flutter/cupertino.dart';
import 'package:hat_draw_app/hdw_classes/hcurr_selection_square.dart';
import 'package:provider/provider.dart';

import '../hdw_state.dart';
import 'draw_button.dart';

class HdwPageFooter extends StatelessWidget {
  const HdwPageFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(flex: 2,),
        DrawButton(items: context.watch<HdwState>().sCurrentItems),
        const Spacer(),
        const HCurrSelectionSquare(),
        const Spacer(),
      ],
    );
  }
}