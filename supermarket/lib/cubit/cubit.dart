import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/cubit/states.dart';
import 'package:supermarket/models/HomeModel.dart';
import 'package:supermarket/network/dioHelper.dart';
import 'package:supermarket/network/endpoins.dart';
import 'package:supermarket/screens/categoriesScreen.dart';
import 'package:supermarket/screens/favouriteScreen.dart';
import 'package:supermarket/screens/productScreen.dart';
import 'package:supermarket/screens/settingScreen.dart';
import 'package:supermarket/shared/reusable.dart';

class SuperMarketCubit extends Cubit<SuperMarketStates> {
  SuperMarketCubit() : super(superMarketInitialState());
  static SuperMarketCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode() {
    isDark = !isDark;
    emit(AppChangeModeStates());
  }

  int currentindex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingScreen(),
  ];

  void changeBottomIndex(int index) {
    currentindex = index;
    emit(SuperChangeBottomNavState());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(SuperLoadingHomeDataState());
    DioHelper.getData(
      path: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromjson(value.data);
      print(homeModel!.data!.banners?[0].image);
      emit(SuperSucssesomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(SuperFailureHomeDataState(error));
    });
  }
}
