import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list/pages/landing_screen.dart';
import 'package:task_list/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(StreamProvider<User?>.value(
    value: AuthService().currentUser,
    initialData: null,
    child: MaterialApp(
      title: 'Список дел',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
      },
    ),
  ));
}
