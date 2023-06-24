import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///Application Constants
class AppConstants {
  static void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[700],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

///API Constants
class ApiConstants {
  static const String baseUrl =
      "http://api.weatherapi.com/v1/current.json?key=e70e65d785d248b98a601706232406&q=Molepos%20Location&aqi=no";
  static const String apiKey = "e70e65d785d248b98a601706232406";
}
