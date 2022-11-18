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

  void modItem(String item, String newVal) {
    int index = mItems.indexOf(item);
    mItems[index] = newVal;
  }
}