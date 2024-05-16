import 'package:flutter/material.dart';

import 'RegisterForm.dart';

class RegisterComponent extends StatefulWidget {
  const RegisterComponent({super.key});

  @override
  State<RegisterComponent> createState() => _RegisterComponent();
}

class _RegisterComponent extends State<RegisterComponent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/logo.png",
                    height: 150,
                    width: 200,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Register!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SignUpform(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
