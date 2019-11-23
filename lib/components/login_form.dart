import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Google e-mail'),
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
        ],
      ), // Build this out in the next steps.
    );
  }
}
