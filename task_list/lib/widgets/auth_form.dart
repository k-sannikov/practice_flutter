import 'package:flutter/material.dart';

import 'button.dart';
import 'input.dart';

class AuthForm extends StatelessWidget {
  const AuthForm(
      {Key? key,
        required this.text,
        required this.handler,
        required this.emailController,
        required this.passwordController})
      : super(key: key);

  final String text;
  final VoidCallback handler;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              top: 10,
            ),
            child: Input(
              icon: const Icon(Icons.email),
              hint: 'Email',
              controller: emailController,
              secure: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Input(
              icon: const Icon(Icons.lock),
              hint: 'Пароль',
              controller: passwordController,
              secure: true,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Button(text: text, handler: handler),
            ),
          )
        ],
      ),
    );
  }
}