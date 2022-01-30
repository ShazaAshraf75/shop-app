// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/states.dart';
import 'package:shopping_app/model/categories_model.dart';
import 'package:shopping_app/model/home_model.dart';
import 'package:shopping_app/modules/search/search_screen.dart';
import 'package:shopping_app/shared/styles/themes/theme.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavouritesState) {
          if (!state.model.status) {
            showToast(text: state.model.message, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        var homeModel = ShopCubit.get(context).homeModel;
        var categoriesModel = ShopCubit.get(context).categoriesModel;
        return ConditionalBuilder(
          condition: homeModel != null && categoriesModel != null,
          builder: (context) =>
              productsBuilder(homeModel!, categoriesModel!, context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      Scaffold(
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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CarouselSlider(
                      items: model.data.banners
                          .map((e) => Image(
                                image: NetworkImage(e.image),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ))
                          .toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: 200,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      )),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Categories",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildCategoryItem(
                              categoriesModel.data.data[index]),
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 5),
                          itemCount: categoriesModel.data.data.length),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "New Products",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Container(
                color: Colors.grey[300],
                child: GridView.count(
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.75,
                  children: List.generate(
                      model.data.products.length,
                      (index) => buildGridProduct(
                          model.data.products[index], context)),
                ),
              ),
            ],
          ),
        ),
      );
  Widget buildCategoryItem(DataModel item) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
                fit: BoxFit.cover,
                height: 100,
                width: 100,
                image: NetworkImage(item.image)),
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.black.withOpacity(.7),
              width: 100,
              child: Text(
                item.name.capitalize(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 9),
              ),
            )
          ],
        ),
      );
  Widget buildGridProduct(ProductModel product, context) => Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Image(
                    image: NetworkImage(product.image),
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                if (product.discount != 0)
                  Container(
                    padding: const EdgeInsets.all(3),
                    color: Colors.red[600],
                    child: const Text(
                      "Discount",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14,
                        letterSpacing: 0,
                        color: Colors.black,
                        height: 1.1),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${(product.price / 60).round()} KD",
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 1,
                          color: redColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (product.discount != 0)
                        Text(
                          "${(product.oldPrice / 60).round()}",
                          style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 1,
                            color: greyColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor:
                            ShopCubit.get(context).favourites[product.id]!
                                ? redColor
                                : greyColor,
                        radius: 14,
                        child: IconButton(
                            iconSize: 13,
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changeFavourites(product.id);
                              print(product.id);
                            },
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
