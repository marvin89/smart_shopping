import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopping/components/conditional_content.dart';
import 'package:smart_shopping/pages/shopping_list.dart';
import 'package:smart_shopping/pages/welcome.dart';
import 'package:smart_shopping/state/search.dart';
import 'package:smart_shopping/state/user.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  User _user;
  Search _search;
  static const platform = MethodChannel('app.channel.shared.data');

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    getSharedText();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User>(context);
    _search = Provider.of<Search>(context);

    return Observer(
      builder: (context) => ConditionalContent(
        condition: _user.isLoggedIn,
        truthy: ShoppingList(),
        falsy: Welcome(),
      ),
    );
  }

  getSharedText() async {
    try {
      final String searchQuery = await platform.invokeMethod('getSavedNote');
      if (searchQuery != null && searchQuery.isNotEmpty) {
        _search.setSearchQuery(searchQuery);
        Navigator.pushReplacementNamed(
          context,
          'shopping-list/$searchQuery',
        );
      }
    } on PlatformException catch (error) {
      print(error.message);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      getSharedText();
    }
  }
}
