import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/cubit/states.dart';
import 'package:supermarket/models/HomeModel.dart';
import 'package:supermarket/models/categoriesModel.dart';
import 'package:supermarket/models/changeFavouriteModel.dart';
import 'package:supermarket/models/favouriteModel.dart';
import 'package:supermarket/models/loginModel.dart';
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
  Map<int, bool> favourite = {};
  void getHomeData() {
    emit(SuperLoadingHomeDataState());
    DioHelper.getData(
      path: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromjson(value.data);
      print(homeModel!.data!.banners?[0].image);
      homeModel!.data!.products!.forEach((element) {
        if (element.in_favourites != null) {
          favourite[element.id!] = element.in_favourites!;
        } else {
          // Initialize with default value if in_favourites is null
          favourite[element.id!] = false;
        }
      });
      print(favourite.toString());
      emit(SuperSucssesomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(SuperFailureHomeDataState(error));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoryData() {
    DioHelper.getData(
      path: GETCATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuperSucssesCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(SuperFailureCategoriesDataState(error));
    });
  }

  changeFavouriteModel? changefavouritemodel;
  void ChangeFacouriteData(int ProductID) {
    if (favourite.containsKey(ProductID)) {
      favourite[ProductID] = !favourite[ProductID]!;
      emit(SuperChangeFavouriteDataState());

      DioHelper.postData(
        url: GETFAVOURITE,
        data: {'product_id': ProductID},
        token: token,
      ).then((value) {
        changefavouritemodel = changeFavouriteModel.fromJson(value.data);
        print(value.data);
        if (!changefavouritemodel!.status!) {
          favourite[ProductID] = !favourite[ProductID]!;
        } else {
          getFavouriteData();
        }
        emit(SuperSucssesChangeFavouriteDataState(changefavouritemodel!));
      }).catchError((error) {
        favourite[ProductID] = !favourite[ProductID]!;
        emit(SuperFailureChangeFavouriteDataState(error));
      });
    } else {
      // Handle the case where the favourite map does not contain the ProductID
      print('ProductID $ProductID not found in the favourite map');
    }
  }

  FavouritesModel? favouritesModel;

  void getFavouriteData() {
    emit(SuperMarketLoadingGetFavouriteDataState());
    DioHelper.getData(
      path: GETFAVOURITE,
      token: token,
    ).then((value) {
      favouritesModel = FavouritesModel.fromJson(
          value.data); // Use the constructor instead of fromJson
      emit(SuperMarketGetFavouriteDataState());
    }).catchError((error) {
      print(error.toString());
      emit(SuperFailureGetFavouriteDataState(error));
    });
  }

  LoginModel? userModel;

  void getProfileData() {
    DioHelper.getData(
      path: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromjson(value.data);
      print(userModel!.data!.name);
      emit(SuperMarketGetPROFILEDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(SuperFailureGetPROFILEDataState(error));
    });
  }

  void editProfileData({
    required String name,
    required String email,
    required String phone,
  }) {
    DioHelper.putData(
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
      url: UPDATEPROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromjson(value.data);
      print(userModel!.data!.name);
      emit(SuperMarketEDITPROFILEDataState(userModel!));
    }).catchError((error) {
      String errorMessage =
          error.toString(); // Get the error message as a string
      print(errorMessage);
      emit(SuperFailureeditPROFILEDataState(
          errorMessage)); // Emit the error message as a string
    });
  }
}
