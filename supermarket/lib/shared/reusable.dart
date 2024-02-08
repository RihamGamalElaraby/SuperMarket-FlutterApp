import 'package:flutter/material.dart';

void navigateandreplace(context, Widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => Widget),
    (Route<dynamic> route) => false);
void navigatTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );
