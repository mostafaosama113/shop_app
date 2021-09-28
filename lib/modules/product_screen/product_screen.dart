import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shoplayout/cubit/cubit.dart';
import 'package:shop_app/layouts/shoplayout/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var bloc = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: bloc.homeModel != null && bloc.categoriesModel != null,
          builder: (context) => homeBuilder(context, bloc.homeModel),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget homeBuilder(context, HomeModel model) {
    var bloc = HomeCubit.get(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data.banners.map((e) {
              return Image(
                image: NetworkImage(e.image),
                fit: BoxFit.cover,
                width: double.infinity,
              );
            }).toList(),
            options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                autoPlayAnimationDuration: Duration(milliseconds: 600),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 10),
            child: Text(
              'Categories',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 25),
            ),
          ),
          Container(
            height: 140,
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.only(start: 10),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  getCategories(context, bloc, index),
              separatorBuilder: (context, index) => SizedBox(
                width: 20,
              ),
              itemCount: bloc.categoriesModel.dataPage.data.length,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 10, top: 10),
            child: Text(
              'New Products',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 25),
            ),
          ),
          Container(
            color: Colors.blue[300],
            child: GridView.count(
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.7,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                  model.data.products.length,
                  (index) => Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  Image(
                                      height: 200,
                                      // fit: BoxFit.fill,
                                      width: double.infinity,
                                      image: NetworkImage(
                                          model.data.products[index].image)),
                                  if (model.data.products[index].discount != 0)
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(.8),
                                          borderRadius:
                                              BorderRadiusDirectional.only(
                                                  topEnd: Radius.circular(3),
                                                  bottomEnd:
                                                      Radius.circular(3))),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        'DISCOUNT',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 15),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                model.data.products[index].name,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        color: Colors.black,
                                        fontSize: 14,
                                        height: 1.3),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  '${model.data.products[index].price.toString()} EP',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          height: 1.3),
                                ),
                                SizedBox(width: 5),
                                if (model.data.products[index].discount != 0)
                                  Text(
                                    '${model.data.products[index].old_price.toStringAsFixed(2)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Colors.grey,
                                            fontSize: 14,
                                            height: 1.3),
                                  ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(
                                    bloc.favorites[
                                            model.data.products[index].id]
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: bloc.favorites[
                                            model.data.products[index].id]
                                        ? Colors.red
                                        : Colors.grey[700],
                                  ),
                                  onPressed: () {
                                    bloc.AddDeleteFav(
                                        model.data.products[index].id, context);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
            ),
          )
        ],
      ),
    );
  }
}

Widget getCategories(context, bloc, int index) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Image(
        image: NetworkImage(bloc.categoriesModel.dataPage.data[index].image),
        fit: BoxFit.cover,
        width: 130,
        height: 130,
      ),
      Container(
        alignment: Alignment.center,
        width: 130,
        height: 35,
        child: Text(
          bloc.categoriesModel.dataPage.data[index].name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
        color: Colors.black.withOpacity(.8),
      )
    ],
  );
}
