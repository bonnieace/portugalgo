import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/image_strings.dart';
import '../constants/sizes.dart';


class footer extends StatelessWidget {
  const footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: TColors.grey),borderRadius: BorderRadius.circular(100)),
          child: 
          
          IconButton(
            onPressed: ()=>{},
            icon: const Image(
              width:TSizes.iconMd,
              height: TSizes.iconMd,
              image: AssetImage(TImages.google))),
        ),
        const SizedBox(width: TSizes.spaceBtwItems,),
        Container(
          decoration: BoxDecoration(border: Border.all(color: TColors.grey),borderRadius: BorderRadius.circular(100)),
          child: 
          
          IconButton(
            onPressed: (){},
            icon: const Image(
              width:TSizes.iconMd,
              height: TSizes.iconMd,
              image: AssetImage(TImages.hotmail
            
            ))),
        ),
      ],
    );
  }
}
