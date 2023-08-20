import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:organize/model/common/custom_colors.dart';
import 'package:organize/model/common/custom_colors_collections.dart';
import 'package:organize/model/common/custom_icons.dart';
import 'package:organize/model/common/custom_icons_collections.dart';
import 'package:organize/model/todo_list/todo_list.dart';
import 'package:organize/model/todo_list/todo_list_collections.dart';
import 'package:provider/provider.dart';

class AddList extends StatefulWidget {
  const AddList({super.key});

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  CustomColors _selectedColor = CustomColorsCollections().colors.first;
  CustomIcon _selectedIcon = CustomIconsCollections().icons.first;
  final TextEditingController _textInput = TextEditingController();
  String _listName = '';

  @override
  void dispose() {
    _textInput.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _textInput.addListener(() {
      setState(() {
        _listName = _textInput.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New List"),
        actions: [
          TextButton(
              onPressed: _listName.isEmpty
                  ? null
                  : () {
                    final user = Provider.of<User?>(context, listen: false);
                    final todoListRef = FirebaseFirestore.instance.collection("users").doc(user?.uid).collection("todo_list").doc();
                    try {
                      todoListRef.set({
                        "id": todoListRef.id,
                        'title':_textInput.text
                      });
                    } catch (e) {
                      print(e);
                    }
                      // Provider.of<TodoListCollection>(context, listen: false)
                      //     .addTodoList(TodoList(
                      //         id: DateTime.now().toString(),
                      //         title: _textInput.text,
                      //         icon: {
                      //       "id": _selectedIcon.id,
                      //       "color": _selectedColor.id
                      //     }));
                      Navigator.pop(
                        context,
                      );
                    },
              child: Text(
                "Add",
                style: TextStyle(
                    color: _listName.isEmpty ? Colors.grey : Colors.blue),
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _selectedColor.color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _selectedIcon.icon,
              size: 45,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).dialogBackgroundColor.withOpacity(.2),
                shape: BoxShape.rectangle,
              ),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: _textInput,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _textInput.clear();
                          });
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[900]),
                          child: const Icon(
                            Icons.clear,
                            color: Colors.red,
                          ),
                        ))),
              )),
          const SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 16,
            alignment: WrapAlignment.center,
            children: [
              for (CustomColors colors in CustomColorsCollections().colors)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = colors;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _selectedColor.color == colors.color
                                ? Colors.white
                                : Colors.transparent),
                        shape: BoxShape.circle,
                        color: colors.color),
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 16,
            alignment: WrapAlignment.center,
            runSpacing: 8,
            children: [
              for (CustomIcon icons in CustomIconsCollections().icons)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIcon = icons;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _selectedIcon.icon == icons.icon
                                ? Colors.white
                                : Colors.transparent),
                        shape: BoxShape.circle,
                        color: Colors.grey[800]),
                    child: Icon(icons.icon),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
