import 'package:mobx/mobx.dart';

part 'user.g.dart';

class User = UserBase with _$User;

abstract class UserBase with Store {
  @observable
  bool isLoggedIn = false;

  @action
  void setLoginState(state) {
    isLoggedIn = state;
  }
}
