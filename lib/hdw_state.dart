import 'package:flutter/material.dart';
import 'hdw_classes/category_contents.dart';

class HdwState with ChangeNotifier {
  List<String> _categories = ["Eating Out", "Board Games"];
  List<CategoryContents> _catMap = [
    CategoryContents("Eating Out", ["Wendy's", "Taco Baco", "Quiero Mas", "Good Move Cafe"]),
    CategoryContents("Board Games", ["Skull", "Doom", "Dead of Winter", "Betrayal", "San Guo Sha", "Binding of Isaac"])
  ];
  List<String> _currentItems = []; // "Woops! Nothing."
  List<String> _currentFullCategories = [];
  List<String> _previousSelection = [];

  List<String> get sCategories => _categories;
  List<CategoryContents> get sCatContents => _catMap;
  List<String> get sCurrentItems => _currentItems;
  List<String> get sLastSelection => _previousSelection;

  bool addItem(String catName, String item) {
    int index = _categories.indexOf(catName);
    if (-1 == index) return false;
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

  bool editItem(String catName, String itemName, String newValue) {
    print("Editing item: $itemName");
    int index = _categories.indexOf(catName);
    //printCategories(catName);
    if (-1 == index) return false;

    if (_currentItems.contains(itemName)) {
      int indexI = _currentItems.indexOf(itemName);
      _currentItems.remove(itemName);
      _currentItems.insert(indexI, newValue);
    }

    CategoryContents currCat = _catMap[index];
    return currCat.modItem(itemName, newValue);
  }

  bool removeItem(String catName, String itemName) {
    print("Removing item: $itemName");
    int index = _categories.indexOf(catName);
    //printCategories(catName);
    if (-1 == index) return false;
    CategoryContents currCat = _catMap[index];
    _currentItems.remove(itemName);
    //currCat.printItems();
    return currCat.deleteItem(itemName);
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

  bool editCategory(String category, String newText) {
    int index = _categories.indexOf(category);
    if (-1 == index) return false;
    _categories.remove(category);
    _categories.insert(index, newText);
    if (_currentFullCategories.contains(category)) {
      index = _currentFullCategories.indexOf(category);
      _currentFullCategories.remove(category);
      _currentFullCategories.insert(index, newText);
    }
    return true;
  }

  bool deleteCategory(String category) {
    return false;
    //Todo
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

  void printCategories(String target) {
    print("DEBUGGING: ");
    print("Target: $target");
    for (var item in _categories) {
      print(item);
    }
  }

  void clearSelection() {
    _currentItems = [];
    _currentFullCategories = [];
  }

  int itemCount() {
    return _currentItems.length;
  }

  saveAsHistory() {
    _previousSelection = _currentItems;
  }
}



/*
Potential Settings List:
- Choose whether deleting an item removes it from selection
- Choose color (add a christmas option)
- Choose whether to have a pop-up for deleting an item

 */