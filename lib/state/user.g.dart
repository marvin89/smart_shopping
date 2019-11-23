// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$User on UserBase, Store {
  final _$isLoggedInAtom = Atom(name: 'UserBase.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.context.enforceReadPolicy(_$isLoggedInAtom);
    _$isLoggedInAtom.reportObserved();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.context.conditionallyRunInAction(() {
      super.isLoggedIn = value;
      _$isLoggedInAtom.reportChanged();
    }, _$isLoggedInAtom, name: '${_$isLoggedInAtom.name}_set');
  }

  final _$shoppingListAtom = Atom(name: 'UserBase.shoppingList');

  @override
  List<ShoppingItem> get shoppingList {
    _$shoppingListAtom.context.enforceReadPolicy(_$shoppingListAtom);
    _$shoppingListAtom.reportObserved();
    return super.shoppingList;
  }

  @override
  set shoppingList(List<ShoppingItem> value) {
    _$shoppingListAtom.context.conditionallyRunInAction(() {
      super.shoppingList = value;
      _$shoppingListAtom.reportChanged();
    }, _$shoppingListAtom, name: '${_$shoppingListAtom.name}_set');
  }

  final _$UserBaseActionController = ActionController(name: 'UserBase');

  @override
  void setLoginState(dynamic state) {
    final _$actionInfo = _$UserBaseActionController.startAction();
    try {
      return super.setLoginState(state);
    } finally {
      _$UserBaseActionController.endAction(_$actionInfo);
    }
  }
}
