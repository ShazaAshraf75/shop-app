

import 'package:shopping_app/model/change_favourites_model.dart';
import 'package:shopping_app/model/shop_user_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopChangeBottomNavStates extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopLoadingCategoriesDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {}

class ShopSuccessToggleFavouritesState extends ShopStates {}

class ShopSuccessChangeFavouritesState extends ShopStates {
  ChangeFavouritesModel model;
  ShopSuccessChangeFavouritesState(this.model);
}

class ShopErrorChangeFavouritesState extends ShopStates {}

class ShopLoadingGetFavouritesState extends ShopStates {}

class ShopSuccessGetFavouritesState extends ShopStates {}

class ShopErrorGetFavouritesState extends ShopStates {}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {
  ShopUserModel shopUserModel;
  ShopSuccessGetUserDataState(this.shopUserModel);
}

class ShopErrorGetUserDataState extends ShopStates {}

class ShopLoadingUpdateUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {
  ShopUserModel shopUserModel;
  ShopSuccessUpdateUserDataState(this.shopUserModel);
}

class ShopErrorUpdateUserDataState extends ShopStates {}
