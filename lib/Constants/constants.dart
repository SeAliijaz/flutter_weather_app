import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Custom_Widgets/custom_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

///API Constants
class ApiConstants {
  static const String baseUrl =
      "http://api.weatherapi.com/v1/current.json?key=e70e65d785d248b98a601706232406&q=Molepos%20Location&aqi=no";
  static const String apiKey = "e70e65d785d248b98a601706232406";
}

///Application Constants
class AppConstants {
  ///Flutter Toast Method
  static showToast(String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      fontSize: 16.0,
    );
  }

  static progressIndicator(
    String title,
    String type,
  ) {
    return SizedBox(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            )),
            const SizedBox(height: 10),
            Center(
              child: SpinKitWidget(
                size: 50.0,
                color: Colors.blue,
                type: type,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///App Colors
  static List<Color> cardColors = [
    const Color(0xffD763E8),
    const Color(0xff6E63EE),
  ];
  static const List<Color> appBarGradients = [
    Color(0xFF2196F3),
    Colors.white,
  ];
}
