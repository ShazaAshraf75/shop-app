// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/model/shop_search_model.dart';
import 'package:shopping_app/modules/search/cubit/states.dart';
import 'package:shopping_app/shared/network/end_points.dart';
import 'package:shopping_app/shared/network/remote/dio_helper.dart';


class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  ShopSearchModel? shopSearchModel;
  void search({required String text}) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(url: SEARCH, token: token, data: {
      "text": text,
    }).then((value) {
      shopSearchModel = ShopSearchModel.fromJson(value.data);

      emit(ShopSearchSuccessState(shopSearchModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopSearchErrorState());
    });
  }
}
