

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:portugalgo/profile/settings/settings.dart';

import '../login.dart';
import '../verifyemail/verify_email.dart';
import 'exceptions/firebase_auth_exceptions.dart';
import 'exceptions/firebase_exceptions.dart';
import 'exceptions/format_exceptions.dart';
import 'exceptions/platform_exceptions.dart';
import 'users/user_repository.dart';


class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance=>Get.find();
  //variables
  final deviceStorage=GetStorage();
  final _auth=FirebaseAuth.instance;

  //get authenticated data
  User? get authUser=>_auth.currentUser;


  //called from main.dart on launch

 /* @override
  void onReady(){
    FlutterNativeSplash.remove();
    screenRedirect();
  }*/
  //function to show relevant screen

  screenRedirect() async{
    final user=_auth.currentUser;
    if(user!=null){
      if (user.emailVerified){
        Get.offAll((()=>LoginScreen()));
        
      }else{
        Get.offAll(()=>verifyEmailScreen(email: _auth.currentUser?.email,));
      }
    }else{
            //check if it is first time launching the app
//deviceStorage.writeIfNull('isFirstTime', true);
//deviceStorage.read('isFirstTime')!= true? Get.offAll((()=>LoginScreen())):Get.offAll((()=>onBoardingScreen()));

    }
  }
  
//create account
  Future <UserCredential> registerWithEmailAndPassword(String email,String password) async{
    try{
      return await _auth.createUserWithEmailAndPassword(email:email,password:password);

    }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
        throw TFirebaseException(e.code).message;
    }on FormatException  catch(_){
      throw TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'something went qrong';
    }
 }
 //login with email and password

   Future <UserCredential> loginWithEmailAndPassword(String email,String password) async{
    try{
      return await _auth.signInWithEmailAndPassword(email:email,password:password);

    }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
        throw TFirebaseException(e.code).message;
    }on FormatException  catch(_){
      throw TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'something went qrong';
    }
 }
 //email verification
 Future<void> sendEmailVerification() async{
      try{
       await _auth.currentUser?.sendEmailVerification();

    }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
        throw TFirebaseException(e.code).message;
    }on FormatException  catch(_){
      throw TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'something went qrong';
    }


 }
   //email REAUTH
 Future<void> reAuthenticateWithEmailAndPassword(String email,String password) async{
      try{
          AuthCredential credential=EmailAuthProvider.credential(email: email, password: password);
          await _auth.currentUser!.reauthenticateWithCredential(credential);
    }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
        throw TFirebaseException(e.code).message;
    }on FormatException  catch(_){
      throw TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'something went qrong';
    }


 }
 //delete user
 Future<void> deleteAccount()async{
  try{
  await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
  await _auth.currentUser?.delete();
  }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
        throw TFirebaseException(e.code).message;
    }on FormatException  catch(_){
      throw TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }
  catch(e){
    throw 'something went wrong';
  }
 }
  //email reset
 Future<void> sendPasswordReset(String email) async{
      try{
       await _auth.sendPasswordResetEmail(email: email);

    }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
        throw TFirebaseException(e.code).message;
    }on FormatException  catch(_){
      throw TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'something went qrong';
    }


 }
 //logout
  Future<void> logout() async{
      try{
        await GoogleSignIn().signOut();
       await FirebaseAuth.instance.signOut();
       Get.offAll(()=>LoginScreen());

    }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
        throw TFirebaseException(e.code).message;
    }on FormatException  catch(_){
      throw TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'something went qrong';
    }


 }
 //google signin
   Future<UserCredential?> SignInWithGoogle() async{
    try{
      final GoogleSignInAccount? userAccount=await GoogleSignIn().signIn();
      //obtain auth details fromthe request
      final GoogleSignInAuthentication? googleAuth= await userAccount?.authentication;

      //create new credential
      final Credentials=GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
      );
      //pass to firebase
      return await _auth.signInWithCredential(Credentials);
      

    }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
        throw TFirebaseException(e.code).message;
    }on FormatException  catch(_){
      throw TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'something went qrong';
    }
 }
}