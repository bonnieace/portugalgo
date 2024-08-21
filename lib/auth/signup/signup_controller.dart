import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../constants/image_strings.dart';
import '../../helpers/network_manager.dart';
import '../authentication/auth_repository.dart';
import '../authentication/users/user_repository.dart';
import '../user_model.dart';
import '../verifyemail/verify_email.dart';


class SignUpcontroller extends GetxController{

  static SignUpcontroller get instance=>Get.find();
  //variables
  final hidePassword=true.obs;
  final toggleTC=true.obs;

  final email =TextEditingController();
  final lastName =TextEditingController();
  final username =TextEditingController();
  final password =TextEditingController();
  final firstname =TextEditingController();
  final phoneNumber =TextEditingController();
  GlobalKey<FormState> signupFormKey =GlobalKey<FormState>();

  Future<http.Response> _insertUser() {
    final url = Uri.parse('https://api.global-software.org/management/user/insert');
    return http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'X-Api-Key': '6b21ac76-6753-4fc7-b5f8-2e93881b577c',
      },
      body: jsonEncode(<String, String>{
        "ana_id": username.text.trim(),
        "ana_nome": firstname.text.trim(),
        "ana_cognome": lastName.text.trim(),
        "ana_email": email.text.trim(),
        "ana_telefono": phoneNumber.text.trim(),
        "ana_password": password.text.trim(),
      }),
    );
  }
  //signup
  Future <void> signup()async{
    if (signupFormKey.currentState!.validate()) {
     

      final response = await _insertUser();

      

      if (response.statusCode == 200) {
        final responseBody = response.body.trim();

        if (responseBody == '1') {
          // Navigate to the verify email screen
        //Get.to(() => const verifyEmailScreen());
        try{
      //start loading
    /*  TFullScreenLoader.openLoadingDialog('we are processing your info....',TImages.loader);

      //check internet connectivity
      final isConnected= await NetworkManager.instance.isConnected();
      if(!isConnected){
                TLoaders.warningSnackBar(title: 'Connect to the internet',message: 'In order to create an account you must first be connected to mobile data or a wifi connection');

                    TFullScreenLoader.stopLoading();

        return;
      }*/

      //form validation
     /* if(!signupFormKey.currentState!.validate()){
                  //  TFullScreenLoader.stopLoading();

                return;


      }*/
      //privacy policy
   /*   if (!toggleTC.value){
        TLoaders.warningSnackBar(title: 'Accept Privacy Policy',message: 'In order to create an account you must first read and accept the terms and conditions');
                        TFullScreenLoader.stopLoading();

     return;
      }*/
      //register user
     final user=await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());
      // saved data
      final newUser=UserModel(id:user.user!.uid,firstName:firstname.text.trim(),lastName:lastName.text.trim(),userName:username.text.trim(),email:email.text.trim(),phoneNumber:phoneNumber.text.trim(),profilePicture:'');
      final userRepository=Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);
             //     TFullScreenLoader.stopLoading();


      //show success
      TLoaders.successSnackBar(title: 'Congratulations',message: 'Account created! Verify email to continue');
      
      Get.to(()=>verifyEmailScreen(email: email.text.trim(),));
        }
    catch(e){


TLoaders.errorSnackBar(title:'Oh Snap!',message:e.toString());
    }
          
        }
        else {
        // Handle the error, show a dialog, toast, etc.
                TLoaders.errorSnackBar(title:'Oh Snap!',message: responseBody);

      }
        
      } else {
        // Handle the error, show a dialog, toast, etc.
          TLoaders.errorSnackBar(title:'Oh Snap!');

      }
    }

     
  }

}