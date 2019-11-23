import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopping/components/conditional_content.dart';
import 'package:smart_shopping/pages/shopping_list.dart';
import 'package:smart_shopping/pages/welcome.dart';
import 'package:smart_shopping/state/user.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User _user;

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User>(context);

    return Observer(
      builder: (context) => ConditionalContent(
        condition: _user.isLoggedIn,
        truthy: ShoppingList(),
        falsy: Welcome(),
      ),
    );
  }
}
