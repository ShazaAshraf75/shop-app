import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/states.dart';
import 'package:shopping_app/model/categories_model.dart';
import 'package:shopping_app/modules/search/search_screen.dart';
import 'package:shopping_app/shared/styles/themes/theme.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var categoriesModel = ShopCubit.get(context).categoriesModel;
        return Scaffold(
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
              itemBuilder: (context, index) => categoriesItemBuilder(
                  categoriesModel!.data.data[index], context),
              separatorBuilder: (context, index) => const Divider(
                    height: 0,
                    indent: 10,
                    endIndent: 10,
                  ),
              itemCount: categoriesModel!.data.data.length),
        );
      },
    );
  }

  Widget categoriesItemBuilder(DataModel item, context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: redColor!.withOpacity(.4), width: 1.5)),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              height: 120,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    item.image,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              item.name.capitalize(),
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                  ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              color: redColor,
            ),
          ],
        ),
      );
}
