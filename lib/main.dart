import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_shopping/config/router.dart';
import 'package:smart_shopping/pages/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  ApplicationRouter.configureRoutes();
  runApp(SmartShopping());
}

class SmartShopping extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SmartShoppingState();
}

class _SmartShoppingState extends State<SmartShopping> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: Home(),
      initialRoute: 'home',
      onGenerateRoute: ApplicationRouter.router.generator,
    );
  }
}
