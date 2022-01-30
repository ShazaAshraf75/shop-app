import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopSearchScreen extends StatelessWidget {
  const ShopSearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocProvider(
        create: (context) => ShopSearchCubit(),
        child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var shopSearchModel = ShopSearchCubit.get(context).shopSearchModel;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Search Screen"),
              ),
              body: Form(
                key: formkey,
                child: Column(children: [
                  defaultTextField(
                      context: context,
                      controller: searchController,
                      radius: 25,
                      padding: 20,
                      onChange: (text) {
                        ShopSearchCubit.get(context).search(text: text!);
                      },
                      prefixIcon: Icons.search,
                      label: "Search",
                      textInputType: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Search Field Must Not Be Empty";
                        }
                        return null;
                      }),
                  if (state is ShopSearchLoadingState)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey[400],
                      ),
                    ),

                  //*******************************************************

                  if (state is ShopSearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => buildListProducts(
                              shopSearchModel!.data!.data![index], context,
                              isOldPrice: false),
                          separatorBuilder: (context, index) => const Divider(
                                height: 0,
                                indent: 15,
                                endIndent: 15,
                              ),
                          itemCount: shopSearchModel!.data!.data!.length),
                    ),
                ]),
              ),
            );
          },
        ));
  }
}
