
// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/models/address_model.dart';
import 'package:shop_app/models/carts_model.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_carts_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/order_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shop_cubit/states.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
  ];

  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  Map<int, bool> carts = {};
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      path: HOME,
      token:token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element['id'] : element['in_favorites'],
        });
        carts.addAll({
          element['id'] : element['in_cart'],
        });
      });
      print(favorites.toString());
      // print(homeModel!.status);
      // print(homeModel!.data!.banners[0]['id']);
      // print(homeModel.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((onError){
      emit(ShopErrorHomeDataState());
      print('Error Here When Get Data Model ===> ${onError.toString()}');
    });

  }


  CategoriesModel? categoriesModel;
  void getCategories(){
    DioHelper.getData(
      path: GET_CATEGORIES,
      token:token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJason(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((onError){
      emit(ShopErrorCategoriesState());
      print('Error Here When Get Categories ===> ${onError.toString()}');
    });

  }


  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId){
    favorites[productId] = !favorites[productId]!;
    emit(ShopLoadingChangeFavoritesState());
    DioHelper.postData(
      path: FAVORITES,
      data: {
        "product_id" : productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromjson(value.data);
      print(value.data);
      if(!changeFavoritesModel!.status!){
        favorites[productId] = !favorites[productId]!;
      }
      else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((onError){
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }


  FavoritesModel? favoritesModel;
  void getFavorites(){
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      path: FAVORITES,
      token:token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((onError){
      emit(ShopErrorGetFavoritesState());
      print('Error Here When Get Categories ===> ${onError.toString()}');
    });

  }


  LoginModel? userModel;
  void getUserData(){
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      path: PROFILE,
      token:token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((onError){
      emit(ShopErrorGetUserDataState());
      print('Error Here When Get Categories ===> ${onError.toString()}');
    });

  }


  void updateUserData({
    required String name,
    required String email,
    required String phone,
    required String image,
}){
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      path: UPDATE_PROFILE,
      token:token,
      data :{
        'name' : name,
        'email' : email,
        'phone' : phone,
        'image' : image,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((onError){
      emit(ShopErrorUpdateUserState());
      print('Error Here When Update User Data ===> ${onError.toString()}');
    });

  }

  int? index;
  void clickableFavItem(int productId){
    index = homeModel!.data!.products.indexWhere((element) => (element['id'] == productId));
    print('The Index is Here ====> $index');
    emit(ShopClickableProductState());
  }


  ChangeCartsModel? changeCartModel;
  void changeCarts(int productId){
    carts[productId] = !carts[productId]!;
    emit(ShopLoadingChangeCartsState());
    DioHelper.postData(
      path: CARTS,
      data: {
        "product_id" : productId,
      },
      token: token,
    ).then((value) {
      changeCartModel = ChangeCartsModel.fromJson(value.data);
      print(value.data);
      getCarts();
      getOrder();
      emit(ShopSuccessChangeCartsState());
    }).catchError((onError){
      carts[productId] = !carts[productId]!;
      emit(ShopErrorChangeCartsState());
    });
  }

  CartModel? cartModel;
  void getCarts(){
    emit(ShopLoadingGetCartsState());
    DioHelper.getData(
      path: CARTS,
      token:token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      print('cart Model Here ======> ${cartModel!.toString()}');
      emit(ShopSuccessGetCartsState());
    }).catchError((onError){
      emit(ShopErrorGetCartsState());
      print('Error Here When Get Carts ===> ${onError.toString()}');
    });

  }

  OrderModel? orderModel;
  void getOrder(){
    emit(ShopLoadingGetOrdersState());
    DioHelper.getData(
      path: ORDERS,
      token: token,
    ).then((value) {
      orderModel = OrderModel.fromJson(value.data);
      print('Order Model Here ====> ${orderModel.toString()}');
      emit(ShopSuccessGetOrdersState());
    }).catchError((onError){
      print('Error When Get Order ===> ${onError.toString()}');
      emit(ShopErrorGetOrdersState());
    });
  }



  bool isbottomSheet = false;
  void changeBottomSheer(bool isBottom){
    isBottom = !isBottom;
    emit(ShopChangeBottomSheersState());
  }

  bool? isOnline;
  bool payment(String value){
    if(value == 'cash'){
      isOnline = false;
    }
    else{
      isOnline =true;
    }
    return isOnline!;
  }

  AddressModel? addressModel;
  void addUserAddress({
    required String name,
    required String city,
    required String region,
    required String street,
    required String latitude,
    required String longitude,

}){
    emit(ShopLoadingAddAddressState());
    DioHelper.postData(
      path: ADDRESSES,
      data: {
        name : 'name',
        city : 'city',
        region : 'region',
        street : 'details',
        latitude : 'latitude',
        longitude : 'longitude',
      },
      token: token,
    ).then((value) {
      emit(ShopSuccessAddAddressState());
      addressModel = AddressModel.fromJson(value.data);
      print('${addressModel!}');
      print('${addressModel!.status}');
      print('${addressModel!.message}');
    }).catchError((onError){
      emit(ShopErrorAddAddressState());
      print('Error when add user addresses =====> ${onError.toString()}');
    });
  }

}