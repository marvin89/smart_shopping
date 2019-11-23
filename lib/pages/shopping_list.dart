import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopping/config/http.dart';
import 'package:smart_shopping/state/user.dart';

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  TextEditingController _shoppingItemController = new TextEditingController();
  FocusNode _shoppingItemFocus = new FocusNode();
  User _user;

  @override
  void initState() {
    super.initState();
    _getShoppingList();
  }

  void _getShoppingList() async {
    final savedShoppingList = await http.get('/listShoppingItems');
    print(savedShoppingList);
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User>(context);

    return Observer(
      builder: (context) => Scaffold(
        key: _drawerKey,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              brightness: Brightness.light,
              actionsIconTheme: IconThemeData(color: Colors.blue),
              iconTheme: IconThemeData(color: Colors.blue),
              title: Container(
                child: Card(
                  elevation: 8,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          _drawerKey.currentState.openDrawer();
                        },
                      ),
                      Expanded(
                        child: TextFormField(
                          onFieldSubmitted: _onInputSubmitted,
                          controller: _shoppingItemController,
                          focusNode: _shoppingItemFocus,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      FlatButton(
                        textColor: Colors.blue,
                        onPressed: _onInputSubmitted,
                        child: Text('Add'),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                List.generate(
                  _user.shoppingList.length,
                  (int index) {
                    return _shoppingListWidget(_user.shoppingList, index);
                  },
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(),
      ),
    );
  }

  void _onInputSubmitted([String value]) {
    final inputValue = value ?? _shoppingItemController.text;

    if (inputValue == null || inputValue.length == 0) {
      return;
    }

    setState(() {
      _user.addToShoppingList(new ShoppingItem(name: inputValue, amount: 1));
      _shoppingItemController.clear();
      _shoppingItemFocus.unfocus();
    });
  }

  Widget _shoppingListWidget(List<ShoppingItem> shoppingList, int index) {
    final ShoppingItem item = shoppingList[index];

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text('${item.name.substring(0, 1).toUpperCase()}'),
      ),
      title: Text('${shoppingList[index].name}'),
      trailing: _itemCounter(item, index),
    );
  }

  Widget _itemCounter(ShoppingItem item, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              _user.updateShoppingItemCount(item.amount - 1, index);
            });
          },
        ),
        Text('${item.amount}'),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              _user.updateShoppingItemCount(item.amount + 1, index);
            });
          },
        )
      ],
    );
  }
}
