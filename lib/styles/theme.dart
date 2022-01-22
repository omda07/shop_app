import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
const  defualtColor = Colors.purple;
ThemeData lightTheme =ThemeData(

  scaffoldBackgroundColor: Colors.white10,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    // backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defualtColor,
    elevation: 20.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  fontFamily: 'Jannah',
  primarySwatch: defualtColor,
);