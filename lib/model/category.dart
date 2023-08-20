import 'package:organize/widgets/category_icon.dart';

class Category{
    String name;
    String reminderCount;
    CategoryIcon icon;
    bool isChecked;

    Category({required this.name, required this.reminderCount, required this.icon, this.isChecked = true});
}