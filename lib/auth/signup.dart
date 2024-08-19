import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
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
                const Footer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
class TsSignUpForm extends StatefulWidget {
  const TsSignUpForm({super.key, required this.dark});

  final bool dark;

  @override
  _TsSignUpFormState createState() => _TsSignUpFormState();
}

class _TsSignUpFormState extends State<TsSignUpForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final response = await _insertUser();

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        final responseBody = response.body.trim();

        if (responseBody == '1') {
          // Navigate to the verify email screen
        Get.to(() => const verifyEmailScreen());
          
        }
        else {
        // Handle the error, show a dialog, toast, etc.
        /*ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(responseBody)),
        );*/
      }
        
      } else {
        // Handle the error, show a dialog, toast, etc.
       /* ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create account')),
        );*/
      }
    }
  }

  Future<http.Response> _insertUser() {
    final url = Uri.parse('https://api.global-software.org/management/user/insert');
    return http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'X-Api-Key': '6b21ac76-6753-4fc7-b5f8-2e93881b577c',
      },
      body: jsonEncode(<String, String>{
        "ana_id": _userNameController.text.trim(),
        "ana_nome": _firstNameController.text.trim(),
        "ana_cognome": _lastNameController.text.trim(),
        "ana_email": _emailController.text.trim(),
        "ana_telefono": _phoneController.text.trim(),
        "ana_password": _passwordController.text.trim(),
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: _lastNameController,
                  validator: (value) =>
                      TValidator.validateEmptyText('Last Name', value),
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            controller: _userNameController,
            validator: (value) =>
                TValidator.validateEmptyText('UserName', value),
            decoration: const InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            controller: _emailController,
            validator: (value) => TValidator.validateEmail(value),
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            controller: _phoneController,
            validator: (value) => TValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            controller: _passwordController,
            validator: (value) => TValidator.validatePassword(value),
            decoration: InputDecoration(
              labelText: TTexts.password,
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: IconButton(
                icon: const Icon(Iconsax.eye),
                onPressed: () => {},
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          termsandcondtions(dark: widget.dark),
          const SizedBox(height: TSizes.spaceBtwSections),
          _isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text(TTexts.createAccount),
                  ),
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
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