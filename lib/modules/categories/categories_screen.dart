import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shoplayout/cubit/cubit.dart';
import 'package:shop_app/layouts/shoplayout/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var bloc = HomeCubit.get(context);
          return ConditionalBuilder(
            fallback: (context) => Center(child: CircularProgressIndicator()),
            condition: bloc.categoriesModel != null,
            builder: (BuildContext context) => Container(
                child: ConditionalBuilder(
              condition: bloc.categoriesModel.dataPage.data != null,
              builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => getElement(
                    context, bloc.categoriesModel.dataPage.data[index]),
                itemCount: bloc.categoriesModel.dataPage.data.length,
                separatorBuilder: (BuildContext context, int index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    color: Colors.black,
                    height: 1,
                    width: double.infinity,
                  ),
                ),
              ),
              fallback: (context) => Center(
                child: Text(
                  'Favorite is Empty',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black),
                ),
              ),
            )),
          );
        });
  }

  Widget getElement(context, model) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 20),
          Text(
            model.name,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black, fontSize: 25),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
  }
}
