
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';


class circularcontainer extends StatelessWidget {
  const circularcontainer({
    super.key, this.width, this.height, this.radius=TSizes.cardRadiusLg, this.margin,this.padding, this.child,   this.backgroundColor=TColors.white,  this.showBorder=false,  this.borderColor=TColors.borderPrimary,
  });
  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final Color  backgroundColor;
  final bool showBorder;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color:backgroundColor,
        border: showBorder?Border.all(color: borderColor):null,
      ),
      child: child,
    );
  }
}