import 'package:supermarket/models/changeFavouriteModel.dart';
import 'package:supermarket/models/loginModel.dart';

abstract class SuperMarketStates {}

class superMarketInitialState extends SuperMarketStates {}

class AppChangeModeStates extends SuperMarketStates {}

class SuperChangeBottomNavState extends SuperMarketStates {}

class SuperLoadingHomeDataState extends SuperMarketStates {}

class SuperSucssesomeDataState extends SuperMarketStates {}

class SuperFailureHomeDataState extends SuperMarketStates {
  final String error;
  SuperFailureHomeDataState(this.error);
}

class SuperLoadingCategoriesDataState extends SuperMarketStates {}

class SuperSucssesCategoriesDataState extends SuperMarketStates {}

class SuperFailureCategoriesDataState extends SuperMarketStates {
  final String error;
  SuperFailureCategoriesDataState(this.error);
}

class SuperSucssesChangeFavouriteDataState extends SuperMarketStates {
  final changeFavouriteModel model;
  SuperSucssesChangeFavouriteDataState(this.model);
}

class SuperChangeFavouriteDataState extends SuperMarketStates {}

class SuperFailureChangeFavouriteDataState extends SuperMarketStates {
  final String error;
  SuperFailureChangeFavouriteDataState(this.error);
}

class SuperMarketLoadingGetFavouriteDataState extends SuperMarketStates {}

class SuperMarketGetFavouriteDataState extends SuperMarketStates {}

class SuperFailureGetFavouriteDataState extends SuperMarketStates {
  final String error;
  SuperFailureGetFavouriteDataState(this.error);
}

class SuperMarketLoadingGetPROFILEDataState extends SuperMarketStates {}

class SuperMarketGetPROFILEDataState extends SuperMarketStates {
  final LoginModel loginModel;
  SuperMarketGetPROFILEDataState(this.loginModel);
}

class SuperFailureGetPROFILEDataState extends SuperMarketStates {
  final String error;
  SuperFailureGetPROFILEDataState(this.error);
}

class SuperMarketLoadingeditPROFILEDataState extends SuperMarketStates {}

class SuperMarketEDITPROFILEDataState extends SuperMarketStates {
  final LoginModel loginModel;
  SuperMarketEDITPROFILEDataState(this.loginModel);
}

class SuperFailureeditPROFILEDataState extends SuperMarketStates {
  final String error;
  SuperFailureeditPROFILEDataState(this.error);
}
