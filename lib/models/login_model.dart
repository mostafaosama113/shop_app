import 'package:shop_app/models/user_data_model.dart';

class LoginModel {
  bool status;
  String message;
  UserDataModel userData;

  LoginModel({this.message, this.status, this.userData});
  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userData =
        json['data'] == null ? null : UserDataModel.fromJson(json['data']);
  }
}
