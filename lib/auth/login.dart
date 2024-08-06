import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portugalgo/auth/signup.dart';

import '../constants/colors.dart';
import '../constants/image_strings.dart';
import '../constants/sizes.dart';
import '../constants/text_strings.dart';
import '../helpers/helper_functions.dart';
import '../validators/validation.dart';
import 'forget_password.dart';
import 'socialbuttons.dart';
import 'spacing_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
      final dark=THelperFunctions.isDarkMode(context);

    return  Scaffold(
    body: SingleChildScrollView(
      child: Padding(
        padding: TSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          children:[
      //picture and title
      head(dark: dark),
      //form
      const loginForm(),
      //divider
      divider(dark: dark),
        const SizedBox(height: TSizes.spaceBtwItems),

      //footer
      const footer()
        
        ]),
      ),
    ),
  );
  }
}


class head extends StatelessWidget {
  const head({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
    
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image(
        height: 150,
        image: AssetImage(dark?TImages.lightAppLogo:TImages.darkAppLogo),
      ),
      Text(TTexts.loginTitle,style: Theme.of(context).textTheme.headlineLarge),
      const SizedBox(height: TSizes.sm,)
    
    ],
            );
  }
}

class divider extends StatelessWidget {
  const divider({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Divider(color:dark?TColors.darkGrey:TColors.grey,thickness: 0.5,indent: 60,endIndent: 5,)),
        Text(TTexts.orSignInWith,style: Theme.of(context).textTheme.labelMedium,),
        Flexible(child: Divider(color:dark?TColors.darkGrey:TColors.grey,thickness: 0.5,indent: 60,endIndent: 5,)),
    
      ],
    );
  }
}


class loginForm extends StatelessWidget {
  const loginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
      child: Column(
      children: [
        //email
        TextFormField(
          validator:(value)=> TValidator.validateEmail(value),
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right),labelText:TTexts.email),
        ),
        //password
        const SizedBox(height: TSizes.spaceBtwInputFields,),
         TextFormField(
                  validator: (value)=>TValidator.validatePassword( value),
              
                  decoration:  InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: Icon(Iconsax.password_check ),
                    suffixIcon:
                     IconButton(icon: Icon( Iconsax.eye_slash), onPressed: ()=>{})
                  ),
                ),
            

        const SizedBox(height: TSizes.spaceBtwInputFields/2),
      //remember me
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
      Row(
        children: [
        //  Obx(()=> Checkbox(value: controller.rememberMe.value, onChanged: (value){controller.rememberMe.value=!controller.rememberMe.value;})),
          const Text(TTexts.rememberMe),
        ],
      ),
      TextButton(onPressed: ()=>Get.to(()=>const ForgetPassword()), child: const Text(TTexts.forgetPassword)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwSections
        ),
        SizedBox(width:double.infinity,child: ElevatedButton(onPressed:()=>{}, child: const Text(TTexts.signIn))),
        const SizedBox(height: TSizes.spaceBtwItems),
    
        SizedBox(width:double.infinity,child: OutlinedButton(onPressed:()=>Get.to(() => const SignUpScreen()), child: const Text(TTexts.createAccount))),
      
      
      ],
      
      ),
    ),
    );
  }
}
