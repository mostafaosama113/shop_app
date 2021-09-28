import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shop_app/layouts/shoplayout/cubit/cubit.dart';
import 'package:shop_app/layouts/shoplayout/cubit/states.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/componants.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = HomeCubit.get(context);
        return BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is LogoutLoadingUserState ||
                  state is LoadingUpdateUserState,
              child: Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      onPressed: () => navigateTo(context, SearchScreen()),
                      icon: Icon(Icons.search),
                    ),
                  ],
                  title: Text('Salla'),
                ),
                body: cubit.botttomScreens[cubit.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  onTap: (index) => cubit.changeBottom(index),
                  currentIndex: cubit.currentIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.apps), label: 'Categories'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite), label: 'Favorite'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'Setting'),
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
