// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/cubit/states.dart';
import 'package:shopping_app/model/categories_model.dart';
import 'package:shopping_app/model/change_favourites_model.dart';
import 'package:shopping_app/model/favourites_model.dart';
import 'package:shopping_app/model/home_model.dart';
import 'package:shopping_app/model/shop_user_model.dart';
import 'package:shopping_app/modules/categories/categories_screen.dart';
import 'package:shopping_app/modules/favourite/favourites_screen.dart';
import 'package:shopping_app/modules/products/products_screen.dart';
import 'package:shopping_app/modules/profile/profile_screen.dart';
import 'package:shopping_app/shared/network/end_points.dart';
import 'package:shopping_app/shared/network/remote/dio_helper.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 0;
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      for (var element in homeModel!.data.products) {
        favourites.addAll({element.id: element.inFavorites});
      }
      // print(favourites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    emit(ShopLoadingCategoriesDataState());

    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // print(categoriesModel!.data.data[0].id);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }

  Map<int, bool> favourites = {};
  ChangeFavouritesModel? changeFavouritesModel;
  void changeFavourites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopSuccessToggleFavouritesState());

    DioHelper.postData(
            url: FAVOURITES, data: {"product_id": productId}, token: token)
        .then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
      // print(changeFavouritesModel!.message);
      if (!changeFavouritesModel!.status) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavouritesData();
      }
      emit(ShopSuccessChangeFavouritesState(changeFavouritesModel!));
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;
      emit(ShopErrorChangeFavouritesState());
    });
  }

  FavouritesModel? favouritesModel;
  void getFavouritesData() {
    emit(ShopLoadingGetFavouritesState());

    DioHelper.getData(url: FAVOURITES, token: token).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      // print(value.data.toString());
      emit(ShopSuccessGetFavouritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavouritesState());
    });
  }

  ShopUserModel? shopUserModel;
  void getUserData() {
    emit(ShopLoadingGetUserDataState());

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      shopUserModel = ShopUserModel.fromJson(value.data);
      // print(shopUserModel!.data!.email.toString());

      emit(ShopSuccessGetUserDataState(shopUserModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }

  // ShopUpdateProfileModel? shopUpdateProfileModel;
  void updateUserData(
      {required String name, required String email, required String phone}) {
    emit(ShopLoadingUpdateUserDataState());

    DioHelper.putData(
        url: UPDATE,
        token: token,
        data: {"name": name, "phone": phone, "email": email}).then((value) {
      shopUserModel = ShopUserModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserDataState(shopUserModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }
}
