import 'package:flutter/cupertino.dart';
import 'package:hat_draw_app/hdw_classes/hcurr_selection_square.dart';
import 'package:provider/provider.dart';

import '../hdw_state.dart';
import 'draw_button.dart';

class HdwPageFooter extends StatelessWidget {
  const HdwPageFooter({
    Key? key,
    required bool currSelPage,
  }) : _currSelPage = currSelPage, super(key: key);

  final bool _currSelPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        if (!_currSelPage) const Spacer(),
        DrawButton(items: context.watch<HdwState>().sCurrentItems),
        const Spacer(),
        if (!_currSelPage) const HCurrSelectionSquare(),
        if (!_currSelPage) const Spacer(),
      ],
    );
  }
}