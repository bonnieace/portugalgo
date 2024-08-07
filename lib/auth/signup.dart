import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portugalgo/auth/verify_email.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';
import '../constants/text_strings.dart';
import '../helpers/helper_functions.dart';
import '../validators/validation.dart';
import 'form_divider..dart';
import 'socialbuttons.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=THelperFunctions.isDarkMode(context);
    return Scaffold(
appBar: AppBar(),
body: signupPage(dark: dark),

    );
  }
}

class signupPage extends StatelessWidget {
  const signupPage({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Determine if the screen width is larger than a certain threshold
          bool isLargeScreen = constraints.maxWidth > 600;

          return Padding(
            padding: isLargeScreen
                ? EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.2, // 20% padding on each side
                    vertical: TSizes.defaultSpace)
                : const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  TTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Form
                TsSignUpForm(dark: dark),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Divider
                const TFormDivider(dividerText: TTexts.orSignUpWith),
                const SizedBox(height: TSizes.spaceBtwSections),
                const footer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
class TsSignUpForm extends StatelessWidget {
  const TsSignUpForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                expands: false,
                decoration: const InputDecoration(
                  labelText: TTexts.firstName,
                  prefixIcon: Icon(Iconsax.user )
                ),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields,),
            Expanded(
              child: TextFormField(
                validator: (value)=>TValidator.validateEmptyText('Last Name', value),

                expands: false,
                decoration: const InputDecoration(
                  labelText: TTexts.lastName,
                  prefixIcon: Icon(Iconsax.user )
                ),
              ),
            ),  
     
        
          ],
        ),
        //username
        const SizedBox(height:TSizes.spaceBtwInputFields),
            TextFormField(
                validator: (value)=>TValidator.validateEmptyText('UserName', value),

                expands: false,
                decoration: const InputDecoration(
                  labelText: TTexts.username,
                  prefixIcon: Icon(Iconsax.user_edit )
                ),
              ),     
         //email 
        const SizedBox(height:TSizes.spaceBtwInputFields),
            TextFormField(
                validator: (value)=>TValidator.validateEmail( value),

                expands: false,
                decoration: const InputDecoration(
                  labelText: TTexts.email,
                  prefixIcon: Icon(Iconsax.direct )
                ),
              ),    
              //phone number
        
        const SizedBox(height:TSizes.spaceBtwInputFields),
            TextFormField(
                validator: (value)=>TValidator.validatePhoneNumber( value),

                decoration: const InputDecoration(
                  labelText: TTexts.phoneNo,
                  prefixIcon: Icon(Iconsax.call )
                ),
              ),    
              //password
        const SizedBox(height:TSizes.spaceBtwInputFields),

             TextFormField(
                  validator: (value)=>TValidator.validatePassword( value),
              
                  decoration:  InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: Icon(Iconsax.password_check ),
                    suffixIcon:
                     IconButton(icon: Icon(Iconsax.eye), onPressed: ()=>{})
                  ),
                ),
              
              const SizedBox(height: TSizes.spaceBtwSections),

              //terms and conditions
                termsandcondtions(dark: dark),
              const SizedBox(height: TSizes.spaceBtwSections),
              //signupbutton
              SizedBox(width: double.infinity,child: ElevatedButton(onPressed: ()=>Get.to(()=>const verifyEmailScreen()),child: const Text(TTexts.createAccount),),)                                         
               ]
        
    ),
    );
  }
}

class termsandcondtions extends StatelessWidget {
  const termsandcondtions({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
    //    SizedBox(width:24,height:24,child: Obx(()=> Checkbox(value: controller.toggleTC.value, onChanged: (value)=> controller.toggleTC.value= !controller.toggleTC.value))),
        const SizedBox(width: TSizes.spaceBtwItems,),
        Expanded(
          child: Text.rich(TextSpan(
            children: [
              TextSpan(text: '${TTexts.iAgreeTo} ',style: Theme.of(context).textTheme.bodySmall),
          
              TextSpan(text: TTexts.privacyPolicy,style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark? TColors.white:TColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: dark?TColors.white:TColors.primary
          
          
              )),
          
            TextSpan(text: ' ${TTexts.and} ',style: Theme.of(context).textTheme.bodySmall),
              TextSpan(text: TTexts.termsOfUse,style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark? TColors.white:TColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: dark?TColors.white:TColors.primary
          
          
              )),
            ]
          )),
        )
        
      ],
    
                  );
  }
}