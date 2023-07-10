import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Constants/constants.dart';

class AppBarGradient extends StatelessWidget {
  const AppBarGradient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppConstants.appBarGradients,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
