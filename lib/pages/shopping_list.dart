import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopping/components/conditional_content.dart';
import 'package:smart_shopping/config/http.dart';
import 'package:smart_shopping/state/search.dart';
import 'package:smart_shopping/state/user.dart';
import 'package:translator/translator.dart';

class ShoppingList extends StatefulWidget {
  final String searchQuery;

  ShoppingList({this.searchQuery});

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  GlobalKey<FormState> _searchKey = GlobalKey();
  TextEditingController _shoppingItemController = new TextEditingController();
  SuggestionsBoxController _shoppingItemSuggestionController =
      new SuggestionsBoxController();
  FocusNode _shoppingItemFocus = new FocusNode();
  final translator = GoogleTranslator();
  User _user;
  Search _search;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _getSearchQuery();
    _getShoppingList();
  }

  void _getShoppingList() async {
    try {
      // final data = (await http.get('/listShoppingItems')).data;
      // final List<ShoppingItem> shoppingList =
      //     _parseShoppingList(data['shoppingList']);
      // _user.populateShoppingList(shoppingList);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<ShoppingItem> _parseShoppingList(List shoppingList) {
    List<ShoppingItem> parsedShoppingList = [];
    shoppingList.forEach((item) {
      parsedShoppingList.add(
          ShoppingItem(id: '1', amount: item['amount'], name: item['name']));
    });
    return parsedShoppingList;
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User>(context);
    _search = Provider.of<Search>(context);

    return Observer(
      builder: (context) => Scaffold(
        key: _drawerKey,
        body: ConditionalContent(
          condition: _isLoading,
          truthy: Center(
            child: CircularProgressIndicator(),
          ),
          falsy: CustomScrollView(
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
                        Expanded(
                          child: Form(
                            key: _searchKey,
                            child: TypeAheadField(
                              hideOnEmpty: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                controller: _shoppingItemController,
                                textInputAction: TextInputAction.search,
                                focusNode: _shoppingItemFocus,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 15),
                                  border: InputBorder.none,
                                ),
                              ),
                              suggestionsBoxController:
                                  _shoppingItemSuggestionController,
                              suggestionsCallback: (pattern) async {
                                if (pattern.isNotEmpty) {
                                  final String _suggestionResponse =
                                      (await http.get('$pattern')).data;
                                  final _parsedResponse =
                                      jsonDecode(_suggestionResponse);
                                  final _processedSuggestions =
                                      _processSearchSuggestions(
                                          _parsedResponse);
                                  return _processedSuggestions;
                                } else {
                                  return [];
                                }
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  leading: Icon(Icons.shopping_cart),
                                  title: Text(suggestion.name),
                                );
                              },
                              onSuggestionSelected: (suggestion) {
                                _onSuggestionSelected(suggestion);
                              },
                            ),
                          ),
                        ),
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
        ),
        drawer: Drawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'store-map');
          },
          child: Icon(Icons.map),
        ),
      ),
    );
  }

  void _onSuggestionSelected([suggestion]) {
    suggestion.amount = 1;

    setState(() {
      _user.addToShoppingList(suggestion);
      _shoppingItemController.clear();
      _shoppingItemFocus.unfocus();
    });
  }

  void _getSearchQuery() async {
    final _partialQuery = widget.searchQuery != null
        ? widget.searchQuery.toLowerCase().replaceFirst('add', '').trim()
        : '';
    if (_partialQuery.isNotEmpty) {
      final _translatedSearchQuery =
          await translator.translate(_partialQuery, from: 'en', to: 'ro');
      _shoppingItemController.text = _translatedSearchQuery;
      _shoppingItemFocus.requestFocus();
    }
  }

  List<ShoppingItem> _processSearchSuggestions(_suggestionResponse) {
    List<ShoppingItem> _processedList = [];
    _suggestionResponse['Items'].forEach((item) {
      _processedList
          .add(ShoppingItem(id: item['id'], name: item['name'], amount: 0));
    });
    return _processedList;
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
