import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portugalgo/auth/signup/signup.dart';
import 'package:portugalgo/auth/verifyemail/verify_email.dart';
import 'package:portugalgo/profile/settings/settings.dart';
import 'package:http/http.dart' as http;


import '../constants/colors.dart';
import '../constants/image_strings.dart';
import '../constants/sizes.dart';
import '../constants/text_strings.dart';
import '../helpers/helper_functions.dart';
import '../helpers/network_manager.dart';
import '../validators/validation.dart';
import 'forget_password.dart';
import 'socialbuttons.dart';
import 'spacing_styles.dart';
import 'user.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Determine if the screen width is larger than a certain threshold
            bool isLargeScreen = constraints.maxWidth > 600;

            return Padding(
              padding: isLargeScreen
                  ? EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.2, // 20% padding on each side
                      vertical: TSpacingStyle.paddingWithAppBarHeight.vertical)
                  : TSpacingStyle.paddingWithAppBarHeight,
              child: Column(
                children: [
                  // picture and title
                  head(dark: dark),
                  // form
                  const loginForm(),
                  // divider
                  divider(dark: dark),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  // footer
                  const Footer(),
                ],
              ),
            );
          },
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
          image: AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo),
        ),
        Text(
          TTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: TSizes.sm),
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
        Flexible(
          child: Divider(
            color: dark ? TColors.darkGrey : TColors.grey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(
          TTexts.orSignInWith,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: dark ? TColors.darkGrey : TColors.grey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
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
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            // email
            TextFormField(
              controller: emailController,
              validator: (value) => TValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
            ),
            // password
            const SizedBox(height: TSizes.spaceBtwInputFields),
            TextFormField(
              controller: passwordController,
              validator: (value) => TValidator.validatePassword(value),
              decoration: InputDecoration(
                labelText: TTexts.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: Icon(Iconsax.eye_slash),
                  onPressed: () => {},
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),
            // remember me
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //const Text(TTexts.rememberMe),
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(TTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => checkEmailVerification(context,emailController.text,passwordController.text),
                child: const Text(TTexts.signIn),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignUpScreen()),
                child: const Text(TTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 Future<void> checkEmailVerification(BuildContext context, String email, String password) async {

  final url = 'https://api.global-software.org/management/user/verifyuser?email=$email';

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'X-Api-Key': '6b21ac76-6753-4fc7-b5f8-2e93881b577c',
      },
    );

    if (response.statusCode == 200) {
      final String responseBody = response.body.trim();  // Trim to remove any extra whitespace

      if (responseBody == 'True') {
        // If verified, proceed to login
        await _login(context, email, password);
      } else if (responseBody == 'False') {
        // If not verified, navigate to the verification screen
      TLoaders.errorSnackBar(title: 'Account error',message: 'Unverified account detected');
      } else {
        // Unexpected response content
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected response: $responseBody')),
        );
      }
    } else {
      // Handle failure
     TLoaders.errorSnackBar(title: 'Oh snap!',message: 'Verification check failed. Please try again.');
    }
  } catch (e) {
    // Handle exceptions (network errors, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred: $e')),
    );
    print(e);
  }
}

Future<void> _login(BuildContext context, String email, String password) async {
      TLoaders.successSnackBar(title: 'Just a minute!',message: 'Let us verify your account');


  final url = 'https://api.global-software.org/management/user/get?email=$email&password=$password';

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'X-Api-Key': '6b21ac76-6753-4fc7-b5f8-2e93881b577c',
      },
    );

    if (response.statusCode == 200) {
      // Check if the response is JSON or plain text
      final contentType = response.headers['content-type'];
      if (contentType != null && contentType.contains('application/json')) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Extract and print the values with null checks
        final String anaEmail = responseData['ana_email'] ?? 'N/A';
        final String anaId = responseData['ana_id'] ?? 'N/A';
        final String anaNome = responseData['ana_nome'] ?? 'N/A';
        final String anaCognome = responseData['ana_cognome'] ?? 'N/A';

        final emailUser = User(
          email: anaEmail,
          id: anaId,
          firstName: anaNome,
          lastName: anaCognome,
        );

        print('Email: $anaEmail');
        print('First Name: $anaNome');
        print('Last Name: $anaCognome');
        print('ID: $anaId');
              TLoaders.successSnackBar(title: 'Login Success',message:'Continue to manage your advertisements');
          


        // Navigate to the settings screen (or wherever necessary)
        Get.to(() => SettingsScreen(emailUser: emailUser));
      } else {
        // Handle non-JSON response (plain text or other formats)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(' ${response.body}')),
        );
      }
    } else {
      // Handle login failure
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Please try again.')),
      );
    }
  } catch (e) {
    // Handle exceptions (network errors, JSON parsing errors, etc.)
    TLoaders.errorSnackBar(title: "Oh Snap!",message: e);
    print(e);
  }

 

}
