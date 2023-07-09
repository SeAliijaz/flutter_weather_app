import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomSpinkit extends StatelessWidget {
  final double? size;
  final Color? color;
  final Widget? child;
  final String? type;

  const CustomSpinkit({
    super.key,
    this.size,
    this.color,
    this.child,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitWidget(
      size: size,
      color: color,
      type: type,
      child: child,
    );
  }
}

class SpinKitWidget extends StatelessWidget {
  final double? size;
  final Color? color;
  final Widget? child;
  final String? type;

  const SpinKitWidget({
    super.key,
    this.size,
    this.color,
    this.child,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'threeBounce':
        return SpinKitThreeBounce(
          size: size!,
          color: color,
        );
      case 'doubleBounce':
        return SpinKitDoubleBounce(
          size: size!,
          color: color,
        );
      case 'fadingCube':
        return SpinKitFadingCube(
          size: size!,
          color: color,
        );
      case 'wave':
        return SpinKitWave(
          size: size!,
          color: color,
        );

      default:
        return SpinKitThreeBounce(
          size: size!,
          color: color!,
        );
    }
  }
}
