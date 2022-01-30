// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, unnecessary_null_comparison, empty_constructor_bodies, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/shared/network/local/cache_helper.dart';
import 'package:shopping_app/shared/network/remote/dio_helper.dart';
import 'package:shopping_app/shared/styles/themes/theme.dart';

import 'components/components.dart';
import 'layout/app_cubit/app_cubit.dart';
import 'layout/app_cubit/app_states.dart';
import 'layout/app_cubit/bloc_observer.dart';
import 'layout/cubit/cubit.dart';
import 'layout/shop_layout.dart';
import 'modules/login/shop_login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: "onBoarding");

  token = CacheHelper.getData(key: "Token");

  if (onBoarding == true) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp(
    this.startWidget,
  );
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode(),
        ),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavouritesData()
              ..getUserData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: shopLightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
