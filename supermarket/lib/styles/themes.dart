import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData LightTheme = ThemeData(
  primarySwatch: Colors.brown,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 83, 48, 35),
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Color.fromRGBO(137, 36, 3, 100),
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color.fromRGBO(137, 36, 3, 100),
    type: BottomNavigationBarType.fixed,
    elevation: 100,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(100, 137, 36, 31),
  ),
  useMaterial3: true,
);

ThemeData DarkTheme = ThemeData(
  primarySwatch: Colors.brown,
  scaffoldBackgroundColor: HexColor('614435'),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor('50301F'),
    iconTheme: const IconThemeData(
      color: Color.fromARGB(255, 211, 166, 150),
    ),
    titleTextStyle: const TextStyle(
      color: Color.fromARGB(255, 234, 231, 231),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('50301F'),
      statusBarBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('705649'),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    elevation: 100,
  ),
);
