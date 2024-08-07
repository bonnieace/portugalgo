import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';
import '../device/device_utility.dart';
import '../helpers/helper_functions.dart';


class TappBar extends StatelessWidget implements PreferredSizeWidget{
  const TappBar({super.key, this.title, this.showBackArrow=false, this.leadingIcon, this.actions, this.leadingOnPressed});
  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List <Widget>? actions;
  final VoidCallback? leadingOnPressed;



  @override
  Widget build(BuildContext context) {
    final dark=THelperFunctions.isDarkMode(context);
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
        child:AppBar(automaticallyImplyLeading: false,
             leading:showBackArrow
             ?IconButton(onPressed: ()=>Get.back(), icon: const Icon(Iconsax.arrow_left,),color: THelperFunctions.isDarkMode(context)? TColors.white:TColors.black,)
             :leadingIcon !=null? IconButton (onPressed: leadingOnPressed, icon:  Icon(leadingIcon)):null,
        title: title,
        actions: actions,

     ) );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight(),
  );
}