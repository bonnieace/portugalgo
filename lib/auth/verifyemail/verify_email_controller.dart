import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../helpers/network_manager.dart';
import '../authentication/auth_repository.dart';
import '../signup/success_screen/success_screen.dart';


class verifyEmailController extends GetxController{

  static verifyEmailController get instance=>Get.find();


  @override
  void onInit(){
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }
  sendEmailVerification()async{
    try{
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(title: 'Email sent',message:'Please check your inbox and verify your email');


    }catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());

    }
  }
    //Timer to automatically redirect on verification
  setTimerForAutoRedirect(){
    Timer.periodic(Duration(seconds: 1), (timer) async{
      await FirebaseAuth.instance.currentUser?.reload();
      final user=FirebaseAuth.instance.currentUser;
      if(user?.emailVerified??false){
        timer.cancel();
        Get.off(()=>SuccessScreen(image: TImages.succ, title: TTexts.yourAccountCreatedTitle, subtitle: TTexts.yourAccountCreatedSubTitle, 
        onPressed: ()=>AuthenticationRepository.instance.screenRedirect()));
      }
     });
  }
  //manually check if email verified\
  checkemailverificationstatus()async
{  final currentUser=FirebaseAuth.instance.currentUser;
  if (currentUser!= null && currentUser.emailVerified){
     Get.off(()=>SuccessScreen(image: TImages.succ, title: TTexts.yourAccountCreatedTitle, subtitle: TTexts.yourAccountCreatedSubTitle, 
        onPressed: AuthenticationRepository.instance.screenRedirect()));
    

  }}

}