import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:portugalgo/auth/login.dart';

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
void setTimerForAutoRedirect() {
  Timer.periodic(Duration(seconds: 1), (timer) async {
    await FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user?.emailVerified ?? false) {
      timer.cancel();
      // Call verifyUser to update backend after verification
      try {
        await verifyUser(user!.email!);
        TLoaders.successSnackBar(title: 'Congrats', message: 'email verified,Login to access your Ads.');
      } catch (e) {
        TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      }
      Get.off(() => LoginScreen());
    }
  });
}

  //manually check if email verified\
Future<void> checkEmailVerificationStatus(String? email) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      // If email is verified, verify user in backend as well
      try {
              await verifyUser(email!);
                      TLoaders.successSnackBar(title: 'Congrats',message: 'email verified,Login to access your Ads.');


        
      } catch (e) {
        TLoaders.errorSnackBar(title: 'oh snap!',message: e);
        
      }
      await verifyUser(email!);
      Get.off(() => LoginScreen());
    }
  }

  // Function to update user verification status in backend
  Future<void> verifyUser(String email) async {
    final String url = 'https://api.global-software.org/management/user/updateverificationuseremail?email=$email&ana_email_verification=true';
    final String apiKey = '6b21ac76-6753-4fc7-b5f8-2e93881b577c'; // API key embedded here 

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'X-Api-Key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        print('User verification updated successfully in backend.');
      } else {
        print('Failed to update user verification. Status code: ${response.statusCode}');
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error updating user verification: $e');
    }
  }

}