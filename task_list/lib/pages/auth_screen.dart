import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_list/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late String _email;
  late String _password;
  bool showLogin = true;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {

    Widget _input(Icon icon, String hint, TextEditingController controller, bool secure) {
      return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: secure,
          style: const TextStyle(fontSize: 20, color: Colors.grey,),
          decoration: InputDecoration(
            hintStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),
            hintText: hint,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 3)
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1)
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: IconTheme(
                data: const IconThemeData(color: Colors.grey),
                child: icon,
              ),
            ),
          ),
        ),
      );
    }

    Widget _button(String text,  void Function() func) {
      return ElevatedButton(
          onPressed: func,
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[300], fontSize: 20),
          )
      );
    }

    Widget _form(String label, void Function() func) {
      return Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10,),
              child: _input(const Icon(Icons.email), 'Email', _emailController, false),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20,),
              child: _input(const Icon(Icons.lock), 'Пароль', _passwordController, true),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20,),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(label, func),
              ),
            )
          ],
        ),
      );
    }

    void _loginButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;

      User? user = await _authService.signInWithEmailAndPassword(_email.trim(), _password.trim());

      if(user == null) {
        Fluttertoast.showToast(
            msg: "Ошибка авторизации! пожалуйста проверьте email или пароль",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    void _registerButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;

      User? user = await _authService.registerWithEmailAndPassword(_email.trim(), _password.trim());

      if(user == null) {
        Fluttertoast.showToast(
            msg: "Ошибка регистрации! пожалуйста проверьте email или пароль",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (
              showLogin
              ? Column(
                children: [
                  _form('Войти', _loginButtonAction),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      child: const Text('Регистрация', style: TextStyle(fontSize: 20, color: Colors.grey)),
                      onTap: () {
                        setState(() {
                          showLogin = false;
                        });
                      },
                    ),
                  )
                ],
              )
              :
              Column(
                children: [
                  _form('Зарегистрироваться', _registerButtonAction),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      child: const Text('Авторизация', style: TextStyle(fontSize: 20, color: Colors.grey)),
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
        ],
      ),
    );
  }
}
