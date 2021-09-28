import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/login/cubit/states.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCutbit extends Cubit<LoginState> {
  LoginCutbit() : super(InitLoginState());

  static LoginCutbit get(context) {
    return BlocProvider.of(context);
  }

  bool isPass = true;
  IconData icon = Icons.visibility_off;
  void toggleHiddenPass() {
    isPass = !isPass;
    icon = isPass ? Icons.visibility_off : Icons.visibility;

    emit(ShowPasswordLoginState());
  }

  void userLogin({@required String email, @required String password}) {
    emit(LoadingLoginState());
    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {
      LoginModel model = LoginModel.fromJson(value.data);
      emit(SuccessLoginState(model));
    }).catchError((error) {
      print(error);
      emit(ErrorLoginState(error.toString()));
    });
  }
}
