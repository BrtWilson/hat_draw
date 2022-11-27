
import 'package:flutter/cupertino.dart';

class HdwConstants {
  HdwConstants._();

  static const String title = "Hat Draw";

  static const String currentSelection = " Current Selection ";
  static const double tileHeight = 50.0;
  static const double tileWidthRedux = 30.0;
  static const double fontSize = 18.0;

  static const String initPage =        '/init';
  static const String categoriesPage =  '/categories';
  static const String itemsPage =       '/items';
  static const String drawPage =        '/draw';

  static const String catArg = 'catName';
  static const String clistArg = 'itemsList';

  static double stdTileWidth(BuildContext context) { return MediaQuery.of(context).size.width - 32.0;}
}