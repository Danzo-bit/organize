import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:organize/model/todo_list/todo_list_collections.dart';
import 'package:organize/screens/add_list.dart';
import 'package:organize/screens/add_reminder.dart';
import 'package:organize/screens/auth/authenticate.dart';
import 'package:provider/provider.dart';

import 'app_wrapper.dart';
import 'screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialize = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialize,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("There was an Error!"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<User?>.value(
          initialData: FirebaseAuth.instance.currentUser,
          value: FirebaseAuth.instance.authStateChanges(),
          child: const AppWrapper());
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}


