import 'package:shop_app/models/login_model.dart';

abstract class HomeState {}

class InitialHomeState extends HomeState {}

class ChangeBottomNavHomeState extends HomeState {}

class LoadingHomeDataState extends HomeState {}

class SuccessHomeDataState extends HomeState {}

class ErrorHomeDataState extends HomeState {}

class SuccessCategoriesDataState extends HomeState {}

class ErrorCategoriesDataState extends HomeState {}

class AddFavStateSuccess extends HomeState {}

class AddFavStateError extends HomeState {}

class SuccessGetFavoriteState extends HomeState {}

class ErrorGetFavoriteState extends HomeState {}

class LoadingGetFavoriteState extends HomeState {}

class SuccessGetUserState extends HomeState {
  final LoginModel loginModel;
  SuccessGetUserState(this.loginModel);
}

class ErrorGetUserState extends HomeState {}

class LoadingGetUserState extends HomeState {}

class SuccessUpdateUserState extends HomeState {
  final LoginModel model;
  SuccessUpdateUserState(this.model);
}

class ErrorUpdateUserState extends HomeState {}

class LoadingUpdateUserState extends HomeState {}

class LogoutLoadingUserState extends HomeState {}

class LogoutSuccessUserState extends HomeState {}

class LogoutErrorUserState extends HomeState {}
