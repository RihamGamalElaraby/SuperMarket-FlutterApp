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
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': Password,
      },
    ).then((value) {
      loginModel = LoginModel.fromjson(value.data);
      print(loginModel?.data?.token);
      print(loginModel?.status);
      print(loginModel?.message);

      emit(ShopLoginSucssesStates(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginSErrorStates(error.toString()));
    });
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
