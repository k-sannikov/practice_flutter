import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_list/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_list/widgets/auth_form.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  late String _email;
  late String _password;
  bool showLogin = true;

  final AuthService _authService = AuthService();

  void _loginButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) return;

    User? user = await _authService.signInWithEmailAndPassword(
        _email.trim(), _password.trim());

    if (user == null) {
      Fluttertoast.showToast(
          msg: "Ошибка авторизации! пожалуйста проверьте email или пароль",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  void _registerButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) return;

    User? user = await _authService.registerWithEmailAndPassword(
        _email.trim(), _password.trim());

    if (user == null) {
      Fluttertoast.showToast(
          msg: "Ошибка регистрации! пожалуйста проверьте email или пароль",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: (showLogin
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthForm(
                    text: 'Войти',
                    handler: _loginButtonAction,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      child: const Text('Регистрация',
                          style: TextStyle(fontSize: 20, color: Colors.grey)),
                      onTap: () {
                        setState(() {
                          showLogin = false;
                        });
                      },
                    ),
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthForm(
                    text: 'Зарегистрироваться',
                    handler: _registerButtonAction,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      child: const Text('Авторизация',
                          style: TextStyle(fontSize: 20, color: Colors.grey)),
                      onTap: () {
                        setState(() {
                          showLogin = true;
                        });
                      },
                    ),
                  )
                ],
              )
        )
    );
  }
}
