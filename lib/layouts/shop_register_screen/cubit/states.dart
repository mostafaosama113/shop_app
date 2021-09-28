import 'package:shop_app/layouts/shoplayout/shop_layout.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/componants.dart';

abstract class RegisterState {}

class InitRegisterState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class SuccessRegisterState extends RegisterState {
  final LoginModel registerModel;
  SuccessRegisterState(this.registerModel) {}
}

class ErrorRegisterState extends RegisterState {
  final String error;
  ErrorRegisterState(this.error);
}
