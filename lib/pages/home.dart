import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Smart Shopping'),
        ),
      ),
      body: Center(
        child: FlatButton(
          color: Colors.blueAccent,
          colorBrightness: Brightness.dark,
          child: Text('Sign in'),
          onPressed: () {
            Navigator.pushNamed(context, 'login');
          },
        ),
      ),
    );
  }
}
