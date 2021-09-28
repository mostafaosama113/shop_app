import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/componants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel model;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
            url: SEARCH,
            data: {'text': text},
            token: CacheHelper.getData('token'))
        .then((value) {
      model = SearchModel(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState(error));
    });
  }
}
