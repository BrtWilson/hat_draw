import 'package:flutter/cupertino.dart';

import '../hdw_constants.dart';

class HdwTitleBar extends StatelessWidget {
  const HdwTitleBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text(HdwConstants.title),
        Image(
          image: AssetImage('assets/tophat_icon.png'),
          height: 30,
          width: 30,
        ),
      ],
    );
  }
}