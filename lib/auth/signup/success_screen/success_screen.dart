import 'package:flutter/material.dart';

import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';
import '../../../helpers/helper_functions.dart';
import '../../spacing_styles.dart';


class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subtitle, required this.onPressed});
  final String image,title,subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: SingleChildScrollView(
        child: Padding(padding: TSpacingStyle.paddingWithAppBarHeight*2,
        child: Column(
          children: [
            ///image
            Image(image:  AssetImage(image),width: THelperFunctions.screenWidth()*0.6,),
            const SizedBox(height: TSizes.spaceBtwSections,),
            
            
            ///title
            Text(title,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
            const SizedBox(height: TSizes.spaceBtwItems,),
            const SizedBox(height: TSizes.spaceBtwSections,),
            //button
            SizedBox(width: double.infinity,child: ElevatedButton(onPressed: onPressed,child: const Text(TTexts.tContinue),)),

                                    
          ],
        ),    ),
      ),
    );
  }
}