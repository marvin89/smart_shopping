import 'package:flutter/material.dart';
import 'package:smart_shopping/components/login_form.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: LoginForm(),
        ),
      ),
    );
  }
}
