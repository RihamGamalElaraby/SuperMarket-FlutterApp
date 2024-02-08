import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/cubit/states.dart';

class SuperMarketCubit extends Cubit<SuperMarketStates> {
  SuperMarketCubit() : super(superMarketInitialState());
  static SuperMarketCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode() {
    isDark = !isDark;
    emit(AppChangeModeStates());
  }
}
