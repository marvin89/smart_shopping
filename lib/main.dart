import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopping/config/router.dart';
import 'package:smart_shopping/pages/home.dart';
import 'package:smart_shopping/state/search.dart';
import 'package:smart_shopping/state/user.dart';

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
    return MultiProvider(
      providers: [
        Provider<User>(builder: (_) => User()),
        Provider<Search>(builder: (_) => Search()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        home: Home(),
        initialRoute: 'home',
        onGenerateRoute: ApplicationRouter.router.generator,
      ),
    );
  }
}
