import 'package:shopping_app/model/shop_search_model.dart';

abstract class ShopSearchStates {}

class ShopSearchInitialState extends ShopSearchStates {}

class ShopSearchLoadingState extends ShopSearchStates {}

class ShopSearchSuccessState extends ShopSearchStates {
  final ShopSearchModel shopSearchModel;
  ShopSearchSuccessState(this.shopSearchModel);
}

class ShopSearchErrorState extends ShopSearchStates {}
