import 'dart:math';

import 'package:flutter/material.dart';

class Constants {
  // static String appName = "AshabulHadith";
  // static String applink = "https://ashabulhadith.com";

  static final Color maincolor = Color.fromRGBO(143, 148, 251, 1);
  static final Color green = Colors.green;

  static int gender = -1;


}

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kSignupColor = Color(0xFF64E9FB);

class CustomColors {
  static const kLightPinkColor = Color(0xffF3ADEC);
  static const kYellowColor = Color(0xffF3AA26);
  static const kCyanColor = Color(0xff0eaeb4);
  static const kPurpleColor = Color(0xff533DC6);
  static const kPrimaryColor = Color(0xff39439f);
  static const kBackgroundColor = Color(0xffF3F3F3);
  static const kLightColor = Color(0xffc4bbcc);
}

class CustomTextStyle {
  static const dayTabBarStyleInactive = TextStyle(
    color: CustomColors.kLightColor,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const dayTabBarStyleActive = TextStyle(
    color: CustomColors.kPrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const metricTextStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25);
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
String getRandomString(int length) {
  Random _rnd = Random();

  return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

List<String> categories = [
  "Advertising/Marketing",
  "Artist",
  "Apparel/Accessories",
  "Automotive",
  "Beauty",
  "Cosmetics/Fragrances",
  "Designer",
  "E-commerce",
  "Education",
  "Electronics",
  "Events",
  "Film/TV/Cable",
  "Financial",
  "Food/Beverage",
  "Haircare",
  "Health/Fitness",
  "Home/Furniture",
  "Hospitality/Hotel",
  "Hotel/Resort",
  "Industrial",
  "Makeup Artist",
  "Medical",
  "Music",
  "Other",
  "Photographer",
  "Publication",
  "Real Estate",
  "Retail",
  "Skincare",
  "Spa",
  "Sports",
  "Stylist",
  "Technology",
  "Travel",
  "Videographer",
];

List<int> categoryIndex = [
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
];
