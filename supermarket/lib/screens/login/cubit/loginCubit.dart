import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/network/dioHelper.dart';
import 'package:supermarket/network/endpoins.dart';
import 'package:supermarket/screens/login/cubit/loginStates.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(ShopLoginInitialStates());
  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String Password}) async {
    emit(ShopLoginLoadingStates());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': Password,
      },
    ).then((value) {
      print(value.data);
      emit(ShopLoginSucssesStates());
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
