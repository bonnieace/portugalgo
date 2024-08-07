import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../device/device_utility.dart';
import '../helpers/helper_functions.dart';


class TTabBar extends StatelessWidget implements PreferredSizeWidget{
  const TTabBar({super.key, required this.tabs});
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark=THelperFunctions.isDarkMode(context);
    return Material(
      color: dark?TColors.black:TColors.white,
      child:  TabBar(
              isScrollable: true,
              indicatorColor: TColors.primary,
              labelColor: THelperFunctions.isDarkMode(context)?TColors.white:TColors.primary,
              unselectedLabelColor: TColors.darkGrey,
              tabs: tabs,
      
            
              )
              ,
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}