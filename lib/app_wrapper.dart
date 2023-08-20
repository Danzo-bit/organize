import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:organize/model/todo_list/todo_list_collections.dart';
import 'package:organize/screens/add_list.dart';
import 'package:organize/screens/add_reminder.dart';
import 'package:organize/screens/auth/authenticate.dart';
import 'package:organize/screens/home.dart';
import 'package:provider/provider.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return ChangeNotifierProvider<TodoListCollection>(
      create: (BuildContext context) {
        return TodoListCollection();
      },
      child: MaterialApp(
        title: 'Organize',

        theme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          iconTheme: const IconThemeData(color: Colors.white),
          scaffoldBackgroundColor: Colors.black,
          textTheme: const TextTheme(
            bodySmall: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
          ),
        ),
        // initialRoute: "/",
        routes: {
          "/authenticate": (context) => const Authenticate(),
          "/home": (context) => const Home(),
          "/addList": (context) => const AddList(),
          "/addReminder": (context) => const AddReminder(),
        },
        home: user != null ? const Home() : const Authenticate(),
      ),
    );
  }

}
