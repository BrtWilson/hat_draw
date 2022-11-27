class CategoryContents {

  late String mCategoryName;
  List<String> mItems = [];

  CategoryContents(String categoryName, List<String> items) {
    mCategoryName = categoryName;
    mItems = items;
  }

  String getName() {
    return mCategoryName;
  }

  String getItem(int n) {
    return mItems[n];
  }

  bool addItem(String item) {
    if (mItems.contains(item)) return false;
    mItems.add(item);
    return true;
  }

  bool deleteItem(String item) {
    return mItems.remove(item);
  }

  bool modItem(String item, String newVal) {
    int index = mItems.indexOf(item);
    if (index == -1) return false;
    mItems[index] = newVal;
    return true;
  }
}