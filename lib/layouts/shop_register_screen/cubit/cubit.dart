import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/login/cubit/states.dart';
import 'package:shop_app/layouts/shop_register_screen/cubit/states.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCutbit extends Cubit<RegisterState> {
  RegisterCutbit() : super(InitRegisterState());

  static RegisterCutbit get(context) {
    return BlocProvider.of(context);
  }

  void registerUser(
    context, {
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    emit(LoadingRegisterState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
    ).then((value) {
      LoginModel model = LoginModel.fromJson(value.data);
      emit(SuccessRegisterState(model));
    }).catchError((error) {
      print(error);
      emit(ErrorRegisterState(error.toString()));
    });
  }
}
