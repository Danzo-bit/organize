import 'package:flutter/material.dart';
import 'package:organize/widgets/category_icon.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final _title = TextEditingController();
  final _notes = TextEditingController();
  String _titleText = "";
  @override
  void initState() {
    super.initState();
    _title.addListener(() {
      setState(() {
        _titleText = _title.text;
      });
    });
  }

  @override
  void dispose() {
    _title.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Reminder"),
        actions: [
          TextButton(
              onPressed: _titleText.isEmpty ? null : () {},
              child: Text(
                "Add",
                style: TextStyle(
                    color:
                        _titleText.isEmpty ? Colors.grey : Colors.blueAccent),
              ))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.1),
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: _title,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Title",
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 100,
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: _notes,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Notes",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                color: Colors.grey.withOpacity(.5),
                child: ListTile(
                  onTap: () {},
                  leading: Text(
                    "List",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.white),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CategoryIcon(icon: Icons.calendar_month),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "New List",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).iconTheme.color,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                color: Colors.grey.withOpacity(.5),
                child: ListTile(
                  onTap: () {},
                  leading: Text(
                    "Category",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.white),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CategoryIcon(icon: Icons.calendar_month),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Schedule",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).iconTheme.color,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
