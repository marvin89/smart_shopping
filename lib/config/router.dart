import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopping/pages/home.dart';
import 'package:smart_shopping/pages/login.dart';
import 'package:smart_shopping/pages/shopping_list.dart';
import 'package:smart_shopping/pages/store_map.dart';

class ApplicationRouter {
  static Router router = Router();

  static Handler routeHandler(page) {
    return Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return page;
      },
    );
  }

  static Handler _homeHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Home());
  static Handler _mapHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          StoreMap());
  static Handler _loginHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Login());
  static Handler _shoppingListHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          ShoppingList(searchQuery: params['searchQuery'][0]));

  static void configureRoutes() {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print("ROUTE WAS NOT FOUND !!!");
        return null;
      },
    );
    router.define('home', handler: _homeHandler);
    router.define('store-map', handler: _mapHandler);
    router.define('login',
        handler: _loginHandler,
        transitionType: TransitionType.materialFullScreenDialog);
    router.define('shopping-list/:searchQuery', handler: _shoppingListHandler);
  }
}
