import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:organize/model/common/custom_colors_collections.dart';
import 'package:organize/model/common/custom_icons_collections.dart';
import 'package:organize/model/listview_items.dart';
import 'package:organize/model/todo_list/todo_list.dart';
import 'package:organize/model/todo_list/todo_list_collections.dart';
import 'package:organize/screens/add_list.dart';
import 'package:organize/screens/add_reminder.dart';
import 'package:organize/services/auth_service.dart';
import 'package:organize/widgets/category_icon.dart';
import 'package:provider/provider.dart';

const LIST_TILE_HEIGHT = 70.0;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ListViewItems items = ListViewItems();
  String view = 'grid';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    var todoLists = Provider.of<TodoListCollection>(
      context,
    ).todoList;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AuthService().logout();
                print(user?.email);
              },
              icon: const Icon(Icons.logout)),
          TextButton(
              onPressed: () {
                print(user);
                setState(() {
                  if (view == 'grid') {
                    view = 'list';
                  } else {
                    view = 'grid';
                  }
                });
              },
              child: Text(
                view == 'grid' ? "Edit" : "Done",
                style: const TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                AnimatedCrossFade(
                  crossFadeState: view == 'grid'
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 300),
                  firstChild: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      shrinkWrap: true,
                      childAspectRatio: 16 / 9,
                      crossAxisCount: 2,
                      children: items
                          .getGridList()
                          .map((category) => Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.15),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        category.icon,
                                        Text(
                                          category.reminderCount,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                    Text(
                                      category.name,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ))
                          .toList()),
                  secondChild: SizedBox(
                    height: items.categories.length * LIST_TILE_HEIGHT +
                        LIST_TILE_HEIGHT,
                    child: ReorderableListView(
                      onReorder: (int oldIndex, int newIndex) {
                        // print("oldIndex $oldIndex");
                        // print("newIndex $newIndex");
                        if (newIndex > oldIndex) {
                          newIndex = newIndex - 1;
                        }
                        final removedCategory = items.removeAt(oldIndex);
                        setState(() {
                          items.insert(newIndex, removedCategory);
                        });
                      },
                      children: items.categories
                          .map((category) => SizedBox(
                                key: UniqueKey(),
                                height: LIST_TILE_HEIGHT,
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      category.isChecked = !category.isChecked;
                                    });
                                  },
                                  leading: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: category.isChecked
                                            ? Colors.blueAccent
                                            : Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: category.isChecked
                                                ? Colors.transparent
                                                : Colors.white)),
                                    child: Icon(
                                      Icons.check,
                                      color: category.isChecked
                                          ? Colors.white
                                          : Colors.transparent,
                                      size: 12,
                                    ),
                                  ),
                                  tileColor: Colors.grey[900],
                                  trailing: const Icon(
                                    Icons.reorder,
                                    color: Colors.white,
                                  ),
                                  title: Row(
                                    children: [
                                      category.icon,
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        category.name,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "My Lists",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: todoLists.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            color: Colors.red,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Icon(Icons.delete),
                            ),
                          ),
                          onDismissed: (direction) {
                            removeList(todoLists[index]);
                          },
                          key: UniqueKey(),
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            elevation: 0,
                            margin: EdgeInsets.zero,
                            color: Colors.grey.withOpacity(.5),
                            child: ListTile(
                              onTap: () {},
                              title: Text(todoLists[index].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(color: Colors.white)),
                              leading: CategoryIcon(
                                color: CustomColorsCollections()
                                    .getColorById(
                                        todoLists[index].icon['color'])
                                    .color,
                                icon: CustomIconsCollections()
                                    .getIconById(todoLists[index].icon['id'])
                                    .icon,
                              ),
                              trailing: const Text(
                                "0",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          // footer
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddReminder(),
                              fullscreenDialog: true));
                    },
                    icon: const Icon(Icons.add_circle),
                    label: const Text("New reminder")),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddList(),
                              fullscreenDialog: true));
                    },
                    child: const Text("Add list"))
              ],
            ),
          )
        ],
      ),
    );
  }

  removeList(TodoList todoList) {
    Provider.of<TodoListCollection>(context, listen: false)
        .removeTodoList(todoList);
  }
}
