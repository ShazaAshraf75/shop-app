// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          // appBar: AppBar(
          //   title: Align(
          //     // alignment: Alignment.centerLeft,
          //     child: Text("Shopping App",
          //         style: Theme.of(context).textTheme.bodyText1),
          //   ),
          //   actions: [
          //     IconButton(
          //         onPressed: () {
          //           navigateTo(context, const SearchScreen());
          //         },
          //         icon: const Icon(
          //           Icons.search,
          //         ))
          //   ],
          // ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottom(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: "Categories",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: "Favourites",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: "Profile",
                ),
              ]),
        );
      },
    );
  }
}
