import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/login/cubit/cubit.dart';
import 'package:shop_app/layouts/login/cubit/states.dart';
import 'package:shop_app/layouts/shop_register_screen/register_screen.dart';
import 'package:shop_app/layouts/shoplayout/shop_layout.dart';
import 'package:shop_app/shared/componants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCutbit, LoginState>(
      listener: (BuildContext context, state) {
        if (state is SuccessLoginState) {
          if (state.model.status) {
            CacheHelper.saveData(
                    key: 'token', value: state.model.userData.token)
                .then((value) {
              navigateToReplacement(context, ShopScreen());
            });
          } else {
            showToest(state.model.message, context);
            emailController.clear();
            passwordController.clear();
          }
        }
      },
      builder: (BuildContext context, state) {
        LoginCutbit bloc = LoginCutbit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login'.toUpperCase(),
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Text(
                        'Login now to browse our hot offrers',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      SizedBox(height: 30),
                      textInput(context,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String value) {
                        if (value.isEmpty)
                          return 'Please enter your Email address';
                      },
                          controller: emailController,
                          prefixIcon: Icons.email_outlined,
                          hint: 'Email Address'),
                      SizedBox(height: 20),
                      textInput(context,
                          keyboardType: TextInputType.text,
                          validator: (String value) {
                            if (value.isEmpty)
                              return 'Please enter your Password';
                          },
                          suffixIcon: bloc.icon,
                          controller: passwordController,
                          suffixPressed: () => bloc.toggleHiddenPass(),
                          prefixIcon: Icons.lock,
                          isPass: bloc.isPass,
                          hint: 'Password'),
                      SizedBox(height: 30),
                      ConditionalBuilder(
                        condition: state is! LoadingLoginState,
                        builder: (context) => customBtn(
                          text: 'Login',
                          isUperCase: true,
                          onClick: () {
                            if (formKey.currentState.validate()) {
                              LoginCutbit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Dont\'t have an account?'),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              navigateTo(context, ShopRegisterScreen());
                            },
                            child: Text(
                              'Register now',
                              style: TextStyle(color: Colors.lightBlueAccent),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
