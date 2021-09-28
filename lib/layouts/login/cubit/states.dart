import 'package:shop_app/models/login_model.dart';

abstract class LoginState {}

class InitLoginState extends LoginState {}

class ShowPasswordLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  final LoginModel model;
  SuccessLoginState(this.model);
}

class ErrorLoginState extends LoginState {
  final String error;
  ErrorLoginState(this.error);
}
