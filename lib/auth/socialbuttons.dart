import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portugalgo/auth/socialsignin/google.dart';
import 'package:portugalgo/profile/settings/settings.dart';

import '../constants/colors.dart';
import '../constants/image_strings.dart';
import '../constants/sizes.dart';
import '../helpers/network_manager.dart';
import 'authentication/auth_repository.dart';
import 'socialsignin/logincontroller.dart';
import 'socialsignin/usercontroller.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(LoginController());


    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: TSizes.lg, vertical: TSizes.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners like in the image
                side: BorderSide(color: TColors.grey), // Border color
              ),
              backgroundColor: Colors.white, // Button background color
              alignment: Alignment.centerLeft, // Align content to the start
            ),
            onPressed: googlesignin,
            icon: const Image(
              width: TSizes.iconMd,
              height: TSizes.iconMd,
              image: AssetImage(TImages.google),
            ),
            label: const Align(
              alignment: Alignment.centerLeft,
              child: Center(
                child: Text(
                  'Google',
                  style: TextStyle(color: Colors.black), // Text color
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems,),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: TSizes.lg, vertical: TSizes.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners like in the image
                side: BorderSide(color: TColors.grey), // Border color
              ),
              backgroundColor: Colors.white, // Button background color
              alignment: Alignment.centerLeft, // Align content to the start
            ),
            onPressed: (){},
            icon: const Image(
              width: TSizes.iconMd,
              height: TSizes.iconMd,
              image: AssetImage(TImages.hotmail),
            ),
            label: const Align(
              alignment: Alignment.centerLeft,
              child: Center(
                child: Text(
                  'Microsoft',
                  style: TextStyle(color: Colors.black), // Text color
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems,),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: TSizes.lg, vertical: TSizes.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners like in the image
                side: BorderSide(color: TColors.grey), // Border color
              ),
              backgroundColor: Colors.white, // Button background color
              alignment: Alignment.centerLeft, // Align content to the start
            ),
            onPressed: (){},
            icon: const Image(
              width: TSizes.iconMd,
              height: TSizes.iconMd,
              image: AssetImage(TImages.appleLogo),
            ),
            label: const Align(
              alignment: Alignment.centerLeft,
              child: Center(
                child: Text(
                  'Apple',
                  style: TextStyle(color: Colors.black), // Text color
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future googlesignin() async {
    final user = await GoogleSignInApi.login();
    if (user == null) {
      print('error');
    } else {
      Get.to(() => SettingsScreen(user: user));
    }
  }


}
