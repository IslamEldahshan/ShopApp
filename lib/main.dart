// ignore_for_file:

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc_observer.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shop_cubit/cubit.dart';
import 'package:shop_app/style/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding')?? false;
  token = CacheHelper.getData(key: 'token');
  BlocOverrides.runZoned(
    () {

      if (onBoarding) {
        if (token != null) {
          widget = const ShopLayout();
        } else {
          widget = LoginScreen();
        }
      } else {
        widget = const OnBoardingScreen();
        print(onBoarding);
      }
      runApp(MyApp(
        startWidget: widget,
      ),);
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  final Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getCarts()..getOrder()..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}
