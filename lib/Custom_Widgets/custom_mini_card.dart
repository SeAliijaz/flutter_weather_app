import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Constants/constants.dart';

class CustomMiniCard extends StatelessWidget {
  final IconData? iconData;
  final String? title;
  // final bool? isWhiteColorNeeded;
  // final FontWeight? fontWeight;
  // final double? fontSize;

  const CustomMiniCard({
    super.key,
    this.iconData,
    this.title,
    // this.isWhiteColorNeeded = false,
    // this.fontWeight,
    // this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: AppConstants.cardColors),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 250,
        width: 200,
        child: Column(
          children: [
            Expanded(
                child: Icon(
              iconData,
              color: Colors.white,
              // color: isWhiteColorNeeded == true ? Colors.white : Colors.black,
            )),
            Expanded(
              child: Text(
                title ?? "title",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold
                    // isWhiteColorNeeded == true ? Colors.white : Colors.black,
                    // fontSize: fontSize,
                    // fontWeight: fontWeight,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
