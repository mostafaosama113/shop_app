import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/shared/componants.dart';

import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var controler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var bloc = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Search'),
              titleSpacing: .5,
            ),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: textInput(context,
                      controller: controler,
                      hint: 'Search',
                      isFocuse: true,
                      prefixIcon: Icons.search,
                      keyboardType: TextInputType.text,
                      onSubmitted: (value) => bloc.search(value)),
                ),
                if (state is SearchLoadingState)
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (bloc.model != null && state is SearchSuccessState)
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
                            height: 120,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Image(
                                  image: NetworkImage(
                                      bloc.model.data[index].image),
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.scaleDown,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        bloc.model.data[index].name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      Spacer(),
                                      Text(
                                        '${bloc.model.data[index].price} E.P',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                                color: Colors.grey,
                                                fontSize: 16),
                                      ),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.black,
                            ),
                        itemCount: bloc.model.data.length),
                  )),
              ],
            ),
          );
        },
      ),
    );
  }
}
