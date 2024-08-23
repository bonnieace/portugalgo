import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portugalgo/auth/login.dart';

import '../../constants/image_strings.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import '../../helpers/helper_functions.dart';
import '../authentication/auth_repository.dart';
import 'verify_email_controller.dart';

class verifyEmailScreen extends StatelessWidget {
  const verifyEmailScreen({super.key, this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(verifyEmailController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => AuthenticationRepository.instance.logout, icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isLargeScreen = constraints.maxWidth > 600;

            return Padding(
              padding: isLargeScreen
                  ? EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.2,
                      vertical: TSizes.defaultSpace,
                    )
                  : const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  if (!isLargeScreen) ...[
                    /// Image for mobile screens
                    Image(
                      image: const AssetImage(TImages.staticSuccessIllustration),
                      width: THelperFunctions.screenWidth() * 0.6,
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                  
                  /// Title
                  Text(
                    TTexts.confirmEmail,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    email ?? '',
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  Text(
                    TTexts.confirmEmailSubTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.checkEmailVerificationStatus(email),
                      child: Text(TTexts.tContinue),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: ()=>controller.sendEmailVerification(),
                      child: const Text(TTexts.resendEmail),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
