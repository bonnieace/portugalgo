import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/sizes.dart';
import '../constants/text_strings.dart';
import '../validators/validation.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
                  // Headings
                  Text(
                    TTexts.forgetPasswordTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    TTexts.forgetPasswordSubTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2),

                  // Textfield
                  Form(
                    child: TextFormField(
                      validator: TValidator.validateEmail,
                      decoration: const InputDecoration(
                        labelText: TTexts.email,
                        prefixIcon: Icon(Iconsax.direct_right),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => {},
                      child: const Text(TTexts.submit),
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
