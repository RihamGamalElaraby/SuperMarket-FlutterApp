abstract class LoginStates {}

class ShopLoginInitialStates extends LoginStates {}

class ShopLoginLoadingStates extends LoginStates {}

class ShopLoginSucssesStates extends LoginStates {}

class ShopLoginSErrorStates extends LoginStates {
  final String error;
  ShopLoginSErrorStates(this.error);
}

class changePassworsVisibailitystate extends LoginStates {}
