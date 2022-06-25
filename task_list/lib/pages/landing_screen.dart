import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list/pages/auth_screen.dart';
import 'package:task_list/pages/task_list_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    final bool isLoggedIn = user != null;

    return isLoggedIn ? const TaskListPage() : const AuthorizationPage();
  }
}
