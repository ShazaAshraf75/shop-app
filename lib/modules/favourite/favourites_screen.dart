import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/states.dart';
import 'package:shopping_app/modules/search/search_screen.dart';


class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var favouritesModel = ShopCubit.get(context).favouritesModel;
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavouritesState,
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Align(
                // alignment: Alignment.centerLeft,
                child: Text("Shopping App",
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, const ShopSearchScreen());
                    },
                    icon: const Icon(
                      Icons.search,
                    ))
              ],
            ),
            body: ListView.separated(
                itemBuilder: (context, index) => buildListProducts(
                    favouritesModel!.data!.data![index].product!, context),
                separatorBuilder: (context, index) => const Divider(
                      height: 0,
                      indent: 15,
                      endIndent: 15,
                    ),
                itemCount: favouritesModel!.data!.data!.length),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
