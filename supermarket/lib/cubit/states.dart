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
