import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/models/searchModel.dart';
import 'package:supermarket/network/dioHelper.dart';
import 'package:supermarket/network/endpoins.dart';
import 'package:supermarket/screens/search/cubit/states.dart';
import 'package:supermarket/shared/reusable.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void Search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, token: token, data: {
      'text': text,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSucssesState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
