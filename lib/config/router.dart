import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopping/pages/home.dart';
import 'package:smart_shopping/pages/login.dart';
import 'package:smart_shopping/pages/shopping_list.dart';

class ApplicationRouter {
  static Router router = Router();

  static Handler routeHandler(page) {
    return Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return page;
      },
    );
  }

  static void configureRoutes() {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print("ROUTE WAS NOT FOUND !!!");
        return null;
      },
    );
    router.define('home', handler: routeHandler(Home()));
    router.define('login',
        handler: routeHandler(Login()),
        transitionType: TransitionType.materialFullScreenDialog);
    router.define('shopping-list', handler: routeHandler(ShoppingList()));
  }
}
