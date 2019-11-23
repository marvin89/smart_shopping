import 'package:mobx/mobx.dart';

part 'user.g.dart';

class User = UserBase with _$User;

abstract class UserBase with Store {
  @observable
  bool isLoggedIn = false;

  @observable
  List<ShoppingItem> shoppingList = [];

  @action
  void setLoginState(state) {
    isLoggedIn = state;
  }

  void addToShoppingList(ShoppingItem item) {
    shoppingList.add(item);
  }

  void updateShoppingItemCount(int amount, int index) {
    if (amount == 0) {
      shoppingList.removeAt(index);
    } else {
      shoppingList[index].amount = amount;
    }
  }
}

class ShoppingItem {
  String name;
  int amount;

  ShoppingItem({this.name, this.amount}) : super();
}
