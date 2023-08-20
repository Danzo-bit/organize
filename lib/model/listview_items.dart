import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:organize/widgets/category_icon.dart';

import 'category.dart';

class ListViewItems {
  final List<Category> _categories = [
    Category(
        name: "Today",
        reminderCount: "0",
        icon: const CategoryIcon(
          icon: CupertinoIcons.calendar_today,
        )),
    Category(
        name: "Scheduled",
        reminderCount: "0",
        icon: const CategoryIcon(
          icon: CupertinoIcons.calendar,
          color: CupertinoColors.systemRed,
        )),
    Category(
        name: "All",
        reminderCount: "0",
        icon: const CategoryIcon(
          icon: CupertinoIcons.calendar_today,
          color: CupertinoColors.systemGrey,
        )),
    Category(
        name: "Flagged",
        reminderCount: "0",
        icon: const CategoryIcon(
          icon: CupertinoIcons.flag,
          color: CupertinoColors.activeOrange,
        )),
  ];

  UnmodifiableListView<Category> get categories =>
      UnmodifiableListView(_categories);

  removeAt(int index) {
    return _categories.removeAt(index);
  }

  insert(int index, Category element) {
    return _categories.insert(index, element);
  }

  List<Category> getGridList() {
    return _categories.where((category) => category.isChecked).toList();
  }
}
