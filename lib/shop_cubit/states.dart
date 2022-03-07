import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopLoadingChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel? model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {
  final LoginModel loginModel;

  ShopSuccessGetUserDataState(this.loginModel);
}

class ShopErrorGetUserDataState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final LoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates {}

class ShopClickableProductState extends ShopStates {}

class ShopLoadingChangeCartsState extends ShopStates {}

class ShopSuccessChangeCartsState extends ShopStates {}

class ShopErrorChangeCartsState extends ShopStates {}

class ShopLoadingGetCartsState extends ShopStates {}

class ShopSuccessGetCartsState extends ShopStates {}

class ShopErrorGetCartsState extends ShopStates {}

class ShopLoadingGetOrdersState extends ShopStates {}

class ShopSuccessGetOrdersState extends ShopStates {}

class ShopErrorGetOrdersState extends ShopStates {}

class ShopLoadingChangeOrdersState extends ShopStates {}

class ShopSuccessChangeOrdersState extends ShopStates {}

class ShopErrorChangeOrdersState extends ShopStates {}

class ShopChangeBottomSheersState extends ShopStates {}

class ShopLoadingAddAddressState extends ShopStates {}

class ShopSuccessAddAddressState extends ShopStates {}

class ShopErrorAddAddressState extends ShopStates {}
