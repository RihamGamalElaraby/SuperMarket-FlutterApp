import 'package:flutter/material.dart';
import 'package:supermarket/network/local/cache_helper.dart';
import 'package:supermarket/screens/login/loginScreen.dart';

String token = '';

void navigateandreplace(context, Widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => Widget),
    (Route<dynamic> route) => false);
void navigatTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );

void signout(context) {
  CacheHelper.removetokenData(key: 'token').then((value) {
    if (value) {
      navigateandreplace(context, LoginScreen());
    }
  });
}
