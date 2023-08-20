import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:organize/services/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Column(
        children: [
          // Lottie.asset('assets/organize.json'),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Organize",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(
            height: 12,
          ),
          Form(
              key: _formState,
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _email,
                    validator: (value) {
                      if (!value!.contains("@")) {
                        return "Provide email";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _password,
                    validator: (value) {
                      if (value!.length < 6 || value.isEmpty) {
                        return "Provide valid password";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formState.currentState!.validate()) {
                          final user = await AuthService()
                              .createUserWithEmailAndPassword(
                                  email: _email.text, password: _password.text);
                          if (user != null) {
                            print(user);
                          }
                        }
                      },
                      child: const Text("Sign Up"))
                ],
              ))
        ],
      ),
    );
  }
}
