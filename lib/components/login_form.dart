import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopping/state/user.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  User _user;

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User>(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            initialValue: 'user@domain.com',
            decoration: InputDecoration(labelText: 'E-mail'),
          ),
          TextFormField(
            initialValue: 'SecretPassw0rd',
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Parola',
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: FlatButton(
              color: Colors.blue,
              colorBrightness: Brightness.dark,
              onPressed: () {
                _user.setLoginState(true);
                Navigator.pop(context);
              },
              child: Text('Login'),
            ),
          ),
        ],
      ), // Build this out in the next steps.
    );
  }
}
