// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Search on SearchBase, Store {
  final _$searchQueryAtom = Atom(name: 'SearchBase.searchQuery');

  @override
  String get searchQuery {
    _$searchQueryAtom.context.enforceReadPolicy(_$searchQueryAtom);
    _$searchQueryAtom.reportObserved();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.context.conditionallyRunInAction(() {
      super.searchQuery = value;
      _$searchQueryAtom.reportChanged();
    }, _$searchQueryAtom, name: '${_$searchQueryAtom.name}_set');
  }

  final _$SearchBaseActionController = ActionController(name: 'SearchBase');

  @override
  void setSearchQuery(dynamic value) {
    final _$actionInfo = _$SearchBaseActionController.startAction();
    try {
      return super.setSearchQuery(value);
    } finally {
      _$SearchBaseActionController.endAction(_$actionInfo);
    }
  }
}
