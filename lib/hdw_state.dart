import 'package:flutter/material.dart';
import 'hdw_classes/category_contents.dart';

class HdwState with ChangeNotifier {
  List<String> _categories = ["Eating Out", "Board Games"];
  List<CategoryContents> _catMap = [
    CategoryContents("Eating Out", ["Wendy's", "Taco Baco", "Quiero Mas", "Good Move Cafe"]),
    CategoryContents("Board Games", ["Skull", "Doom", "Dead of Winter", "Betrayal", "San Guo Sha", "Binding of Isaac"])];
  List<String> _currentItems = []; // "Woops! Nothing."
  List<String> _currentFullCategories = [];

  List<String> get sCategories => _categories;
  List<CategoryContents> get sCatContents => _catMap;
  List<String> get sCurrentItems => _currentItems;

  bool addItem(String catName, String item) {
    int index = _categories.indexOf(catName);
    if (index == -1) return false;
    CategoryContents currCat = _catMap[index];
    return currCat.addItem(item);
  }

  bool addCategory(String catName) {
    if (_categories.contains(catName)) {
      notifyListeners();
      return false;
    }
    else {
      _categories.add(catName);
      _catMap.add(CategoryContents(catName, []));
      notifyListeners();
      return true;
    }
  }

  int catIndex(String item) {
    return _categories.indexOf(item);
  }

  List<String> getItems(String catName) {
    int index = _categories.indexOf(catName);
    if (index == -1) return [];

    return _catMap[index].mItems;
  }

  void setItemInclusion(String item, bool isInsert) {
    if (isInsert) {
      if (!(_currentItems.contains(item))) {
        _currentItems.add(item);
      }
    }
    else {
      _currentItems.remove(item);
    }
  }

  bool checkForCategory(String catName) {
    return _currentFullCategories.contains(catName);
  }

  void setCategoryInclusion(String catName, bool isInsert) {
    if (isInsert) {
      if (!(_currentFullCategories.contains(catName))) {
        _currentFullCategories.add(catName);
      }
    }
    else {
      _currentFullCategories.remove(catName);
    }
    int index = _categories.indexOf(catName);
    List<String> catItems = _catMap[index].mItems;
    for (var item in catItems) {
      setItemInclusion(item, isInsert);
    }
  }
}