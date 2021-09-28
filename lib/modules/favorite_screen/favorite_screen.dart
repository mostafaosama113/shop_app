import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shoplayout/cubit/cubit.dart';
import 'package:shop_app/layouts/shoplayout/cubit/states.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = HomeCubit.get(context);
        return ConditionalBuilder(
            condition: state is! LoadingGetFavoriteState &&
                bloc.favoriteModel != null &&
                bloc.isLoading != null &&
                !bloc.isLoading,
            fallback: (context) => Center(child: CircularProgressIndicator()),
            builder: (context) => ConditionalBuilder(
                  condition: bloc.favoriteModel.data.data.length > 0,
                  fallback: (context) => Center(
                      child: Text(
                    'Empty',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 35, color: Colors.black),
                  )),
                  builder: (context) => ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildFavItem(context,
                          bloc: bloc,
                          productName:
                              bloc.favoriteModel.data.data[index].product.name,
                          image:
                              bloc.favoriteModel.data.data[index].product.image,
                          oldPrice: bloc
                              .favoriteModel.data.data[index].product.oldPrice,
                          price:
                              bloc.favoriteModel.data.data[index].product.price,
                          id: bloc.favoriteModel.data.data[index].product.id),
                      separatorBuilder: (context, index) => Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey,
                          ),
                      itemCount: bloc.favoriteModel.data.data.length),
                ));
      },
    );
  }

  Widget buildFavItem(context,
      {@required String productName,
      @required String image,
      @required dynamic price,
      @required dynamic oldPrice,
      @required int id,
      @required HomeCubit bloc}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Container(
        height: 120.0,
        width: double.infinity,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  height: 120.0,
                  width: 120.0,
                  fit: BoxFit.fill,
                  image: NetworkImage(image),
                ),
                if (price != oldPrice)
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(.8),
                        borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(3),
                            bottomEnd: Radius.circular(3))),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'DISCOUNT',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.white, fontSize: 13),
                    ),
                  )
              ],
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsetsDirectional.only(start: 10, top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.black, fontSize: 20, height: 1.2),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        '${price.toStringAsFixed(1)} EP',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.blue, fontSize: 16, height: 1.3),
                      ),
                      SizedBox(width: 3),
                      if (price != oldPrice)
                        Text(
                          '${oldPrice.toStringAsFixed(1)} EP',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 16,
                              height: 1.3),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          HomeCubit.get(context).AddDeleteFav(id, context);
                        },
                        icon: Icon(
                          bloc.favorites[id]
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: bloc.favorites[id]
                              ? Colors.red
                              : Colors.grey[700],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
