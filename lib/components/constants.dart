
import 'package:flutter/material.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/network/local/cache_helper.dart';

import '../modules/login/login.dart';

const defaultColor = Colors.blue;

void signOut(context){
  CacheHelper.removeDate(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

String? token ;