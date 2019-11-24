import 'package:mobx/mobx.dart';

part 'search.g.dart';

class Search = SearchBase with _$Search;

abstract class SearchBase with Store {
  @observable
  String searchQuery;

  @action
  void setSearchQuery(value) {
    searchQuery = value;
  }
}
