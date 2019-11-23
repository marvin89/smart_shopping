import 'package:flutter/material.dart';

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    FlatButton(
                      textColor: Colors.blue,
                      onPressed: () {},
                      child: Text('Add'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(),
    );
  }
}
