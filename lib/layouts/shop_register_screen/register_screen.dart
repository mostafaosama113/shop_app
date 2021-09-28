import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_register_screen/cubit/cubit.dart';
import 'package:shop_app/layouts/shop_register_screen/cubit/states.dart';
import 'package:shop_app/layouts/shoplayout/shop_layout.dart';
import 'package:shop_app/shared/componants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCutbit, RegisterState>(
      listener: (BuildContext context, state) {
        if (state is SuccessRegisterState) {
          if (state.registerModel.status) {
            CacheHelper.saveData(
                    key: 'token', value: state.registerModel.userData.token)
                .then((value) {
              navigateToReplacement(context, ShopScreen());
            });
          } else {
            print(state.registerModel.message);
            showToest(state.registerModel.message, context);
          }
        }
      },
      builder: (BuildContext context, state) {
        RegisterCutbit bloc = RegisterCutbit.get(context);
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
                        'Register'.toUpperCase(),
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Text(
                        'Register now to browse our hot offrers',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      SizedBox(height: 30),
                      textInput(context, keyboardType: TextInputType.name,
                          validator: (String value) {
                        if (value.isEmpty) return 'Please enter your Name';
                      },
                          controller: nameController,
                          prefixIcon: Icons.person,
                          hint: 'Your Name'),
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
                          isPass: true, validator: (String value) {
                        if (value.isEmpty)
                          return 'Please enter your Password';
                        else if (rePasswordController.text != value)
                          return 'Password should be matched';
                      },
                          controller: passwordController,
                          prefixIcon: Icons.lock,
                          hint: 'Password'),
                      SizedBox(height: 20),
                      textInput(context,
                          keyboardType: TextInputType.text,
                          isPass: true, validator: (String value) {
                        if (value.isEmpty)
                          return 'Please Re-enter your Password';
                        else if (passwordController.text != value)
                          return 'Password should be matched';
                      },
                          controller: rePasswordController,
                          prefixIcon: Icons.lock,
                          hint: 'Re-Enter Password'),
                      SizedBox(height: 20),
                      textInput(context, keyboardType: TextInputType.phone,
                          validator: (String value) {
                        if (value.isEmpty)
                          return 'Please Enter you phone number';
                      },
                          controller: phoneController,
                          prefixIcon: Icons.phone,
                          hint: 'Phone Number'),
                      SizedBox(height: 30),

                      ConditionalBuilder(
                        condition: state is! LoadingRegisterState,
                        builder: (context) => customBtn(
                          text: 'Register',
                          isUperCase: true,
                          onClick: () {
                            if (formKey.currentState.validate()) {
                              bloc.registerUser(
                                context,
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(height: 15),
                      // customBtn(
                      //     text: 'Back to login page',
                      //     onClick: () => Navigator.pop(context),
                      //     bgColor: Colors.green,
                      //     isUperCase: true)
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
