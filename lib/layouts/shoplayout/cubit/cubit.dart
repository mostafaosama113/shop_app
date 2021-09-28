import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/login/shop_login_screen.dart';
import 'package:shop_app/layouts/shoplayout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorite_screen/favorite_screen.dart';
import 'package:shop_app/modules/product_screen/product_screen.dart';
import 'package:shop_app/modules/setting/setting_screen.dart';
import 'package:shop_app/shared/componants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialHomeState());
  static HomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> botttomScreens = [
    ProductScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavHomeState());
  }

  HomeModel homeModel;
  CategoriesModel categoriesModel;
  FavoriteModel favoriteModel;

  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(LoadingHomeDataState());
    DioHelper.getData(url: HOME, token: CacheHelper.getData('token'))
        .then((value) {
      homeModel = HomeModel(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.in_favorites});
      });
      //print(favorites);
      emit(SuccessHomeDataState());
    }).catchError((value) {
      print(value.toString());
      emit(ErrorHomeDataState());
    });
  }

  void getCategoriesData() {
    emit(LoadingHomeDataState());
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel(value.data);
      emit(SuccessHomeDataState());
    }).catchError((value) {
      print(value.toString());
      emit(ErrorHomeDataState());
    });
  }

  void AddDeleteFav(int id, context) {
    isLoading = true;
    favorites.update(id, (value) => !favorites[id]);
    emit(AddFavStateSuccess());
    DioHelper.postData(
      url: FAVORITE,
      data: {
        'product_id': '$id',
      },
      token: CacheHelper.getData('token'),
    ).then((value) {
      if (!value.data['status']) {
        favorites.update(id, (value) => !favorites[id]);
        showToest(value.data['message'].toString(), context);
      } else
        getFavorite();
      emit(AddFavStateSuccess());
    }).catchError((error) {
      favorites.update(id, (value) => !favorites[id]);
      showToest(error.data['message'].toString(), context);
      print(error);
      emit(AddFavStateError());
    });
  }

  bool isLoading = true;

  void getFavorite() {
    emit(LoadingGetFavoriteState());
    isLoading = true;
    DioHelper.getData(
      url: FAVORITE,
      token: CacheHelper.getData('token'),
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(SuccessGetFavoriteState());
    }).catchError((value) {
      print(value.toString());
      emit(ErrorGetFavoriteState());
    });
    isLoading = false;
  }

  LoginModel userModel;
  void getUserMode() {
    emit(LoadingGetUserState());
    DioHelper.getData(
      url: PROFILE,
      token: CacheHelper.getData('token'),
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(SuccessGetUserState(userModel));
    }).catchError((value) {
      print(value.toString());
      emit(ErrorGetUserState());
    });
  }

  void updateUserMode(
    context, {
    @required String name,
    @required String phone,
    @required String email,
  }) {
    emit(LoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATEDATA,
      token: CacheHelper.getData('token'),
      data: {'name': name, 'email': email, 'phone': phone},
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(SuccessUpdateUserState(userModel));
      showToest(userModel.message, context);
    }).catchError((value) {
      print(value.toString());
      emit(ErrorUpdateUserState());
      showToest(userModel.message, context);
    });
  }

  void logout(context) {
    emit(LogoutLoadingUserState());
    DioHelper.postData(
        url: LOGOUT,
        data: {'Authorization': CacheHelper.getData('token')}).then((value) {
      CacheHelper.sharedPreferences.remove('token');
      navigateToReplacement(context, ShopLoginScreen());
      emit(LogoutSuccessUserState());
      currentIndex = 0;
    }).catchError((error) {
      showToest(error.data['message'], context);
      if (CacheHelper.getData('token').isEmpty())
        navigateToReplacement(context, ShopLoginScreen());
      emit(LogoutErrorUserState());
    });
  }
}
