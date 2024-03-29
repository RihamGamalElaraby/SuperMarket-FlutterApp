import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/models/loginModel.dart';
import 'package:supermarket/network/dioHelper.dart';
import 'package:supermarket/network/endpoins.dart';
import 'package:supermarket/screens/login/cubit/loginStates.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(ShopLoginInitialStates());
  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  void userLogin({required String email, required String Password}) async {
    emit(ShopLoginLoadingStates());
    try {
      final response = await DioHelper.postData(
        url: LOGIN,
        data: {
          'email': email,
          'password': Password,
        },
      );
      loginModel = LoginModel.fromjson(response.data);
      print(loginModel?.data?.token);
      print(loginModel?.status);
      print(loginModel?.message);
      if (loginModel!.status!) {
        emit(ShopLoginSucssesStates(loginModel));
      } else {
        emit(ShopLoginSErrorStates(
            loginModel!.message ?? 'Unknown error occurred'));
      }
    } catch (error) {
      print(error.toString());
      emit(ShopLoginSErrorStates(
          'Failed to authenticate. Please try again later.'));
    }
  }

  IconData suffix = Icons.visibility_outlined;
  bool isObsecure = true;
  void changePasswordVisibility() {
    isObsecure = !isObsecure;

    suffix =
        isObsecure ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(changePassworsVisibailitystate());
  }
}
