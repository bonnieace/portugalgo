import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:portugalgo/profile/settings/settings.dart';

import '../../helpers/network_manager.dart';
import '../authentication/auth_repository.dart';
import 'usercontroller.dart';


class LoginController extends GetxController{
  final rememberMe=true.obs;
  final hidePassword=true.obs;
  final storage=GetStorage(); 
  final email=TextEditingController();
  final password=TextEditingController();
  GlobalKey<FormState> loginFormKey=GlobalKey<FormState>();
  final userController=Get.put(UserController());
@override
void onInit(){
  

  super.onInit();
}

  Future <void> emailAndPasswordSignIn() async{
    try{
      //start loadingn
      //check connectivity
    
      //form validation
      
      //save data if remember me  is selected
    /*  if(rememberMe.value){
        storage.write('REMEMBER_ME_EMAIL',email.text.trim());
        storage.write('REMEMBER_ME_PASSWORD',password.text.trim());

      }*/
      //login
      final UserCredentials=await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      AuthenticationRepository.instance.screenRedirect();
    }catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
    }

  }
  Future<void> GoogleSignIn() async{
    try{

           
    
      //google auth
      final UserCredentials=await AuthenticationRepository.instance.SignInWithGoogle();
      print(UserCredentials);
      //save records
      //await userController.saveUserRecord(UserCredentials);

      //remove loader
      //redirect
     // AuthenticationRepository.instance.screenRedirect();
     Get.offAll(()=>SettingsScreen());



    }catch(e){

      TLoaders.errorSnackBar(title: 'oh snap',message: e.toString());
    }
  }
}