import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/models/loginModel.dart';
import 'package:supermarket/network/dioHelper.dart';
import 'package:supermarket/network/endpoins.dart';
import 'package:supermarket/screens/register/cubit/registerStates.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(ShopRegisterInitialStates());
  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  void userRegister(
      {required String email,
      required String Password,
      required String name,
      required String phone}) async {
    emit(ShopRegisterLoadingStates());
    try {
      final response = await DioHelper.postData(
        url: REGISTER,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': Password,
        },
      );
      loginModel = LoginModel.fromjson(response.data);
      print(loginModel?.data?.token);
      print(loginModel?.status);
      print(loginModel?.message);
      if (loginModel!.status!) {
        emit(ShopRegisterSuccessStates(loginModel));
      } else {
        emit(ShopRegisterErrorStates(
            loginModel!.message ?? 'Unknown error occurred'));
      }
    } catch (error) {
      print(error.toString());
      emit(ShopRegisterErrorStates(
          'Failed to authenticate. Please try again later.'));
    }
  }

  IconData suffix = Icons.visibility_outlined;
  bool isObsecure = true;
  void changePasswordVisibility() {
    isObsecure = !isObsecure;

    suffix =
        isObsecure ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordRegisterVisibilityState());
  }
}
