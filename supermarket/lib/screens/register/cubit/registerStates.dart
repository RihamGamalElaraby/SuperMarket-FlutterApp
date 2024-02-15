import 'package:supermarket/models/loginModel.dart';

abstract class RegisterStates {}

class ShopRegisterInitialStates extends RegisterStates {}

class ShopRegisterLoadingStates extends RegisterStates {}

class ShopRegisterSuccessStates extends RegisterStates {
  final LoginModel? loginModel;
  ShopRegisterSuccessStates(this.loginModel);
}

class ShopRegisterErrorStates extends RegisterStates {
  final String error;
  ShopRegisterErrorStates(this.error);
}

class ChangePasswordRegisterVisibilityState extends RegisterStates {}
