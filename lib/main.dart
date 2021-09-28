import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/login/cubit/cubit.dart';
import 'package:shop_app/layouts/login/shop_login_screen.dart';
import 'package:shop_app/layouts/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/layouts/shop_register_screen/cubit/cubit.dart';
import 'package:shop_app/layouts/shoplayout/shop_layout.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/theme.dart';
import 'layouts/shoplayout/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget startWidger;
  bool isBoarding = CacheHelper.getData('onBoarding') ?? false;
  String token = CacheHelper.getData('token') ?? '';
  if (!isBoarding)
    startWidger = OnBoardingScreen();
  else if (token.isEmpty)
    startWidger = ShopLoginScreen();
  else
    startWidger = ShopScreen();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (BuildContext context) => HomeCubit()
          ..getHomeData()
          ..getCategoriesData()
          ..getFavorite()
          ..getUserMode(),
      ),
      BlocProvider(
        create: (BuildContext context) => LoginCutbit(),
      ),
      BlocProvider(
        create: (BuildContext context) => RegisterCutbit(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startWidger,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
    ),
  ));
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
