import 'package:flutter/material.dart';
import 'package:organize/screens/auth/sign_in.dart';
import 'package:organize/screens/auth/sign_up.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton.icon(
            onPressed: () {
              toggleView();
            },
            icon: const Icon(Icons.person),
            label: Text(showSignIn ? "Sign Up" : "Sign In"))
      ]),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: showSignIn ? const SignIn() : const SignUp(),
      ),
    );
  }
}
