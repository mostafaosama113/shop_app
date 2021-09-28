import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shop_app/layouts/shoplayout/cubit/cubit.dart';
import 'package:shop_app/layouts/shoplayout/cubit/states.dart';
import 'package:shop_app/shared/componants.dart';

class SettingScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  SettingScreen() {}
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit bloc = HomeCubit.get(context);

        return ConditionalBuilder(
          condition: bloc.userModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) {
            var model = bloc.userModel;
            nameController.text = model.userData.name;

            emailController.text = model.userData.email;
            phoneController.text = model.userData.phone;
            return Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    textInput(context,
                        controller: nameController,
                        hint: 'Name',
                        prefixIcon: Icons.person, validator: (String value) {
                      if (value.isEmpty) return 'Enter Name';
                    }),
                    SizedBox(height: 20),
                    textInput(context,
                        controller: emailController,
                        hint: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email, validator: (String value) {
                      if (value.isEmpty) return 'Enter Email Address';
                    }),
                    SizedBox(height: 20),
                    textInput(context,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        hint: 'Phone',
                        prefixIcon: Icons.phone, validator: (String value) {
                      if (value.isEmpty) return 'Enter Phone Number';
                    }),
                    Spacer(),
                    customBtn(
                        text: 'Update',
                        bgColor: Colors.green,
                        onClick: () {
                          if (formKey.currentState.validate()) {
                            bloc.updateUserMode(context,
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text);
                          }
                        }),
                    SizedBox(height: 20),
                    customBtn(
                        text: 'Logout',
                        onClick: () {
                          bloc.logout(context);
                        }),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
