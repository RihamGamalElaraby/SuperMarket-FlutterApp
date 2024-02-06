import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/cubit/states.dart';

class NewsCubit extends Cubit<SuperMarketStates> {
  NewsCubit() : super(superMarketInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
}
