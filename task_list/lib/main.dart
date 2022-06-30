import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list/pages/weather_screen.dart';
import 'package:task_list/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:task_list/pages/auth_screen.dart';
import 'package:task_list/pages/task_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const TaskList());
}

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    final bool isLoggedIn = user != null;

    return StreamProvider<User?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: MaterialApp(
        title: 'Список дел',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) =>
                ((Provider.of<User?>(context) != null) ? const TaskListPage() : const AuthorizationPage()),
            settings: settings,
          );
        },
        routes: {
          '/weather' : (context) => const WeatherPage(),
        },
      ),
    );
  }
}
