

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/sizes.dart';
import '../../helpers/network_manager.dart';
import '../authentication/auth_repository.dart';
import '../authentication/users/user_repository.dart';
import '../login.dart';
import '../user_model.dart';


class UserController extends GetxController{

  static UserController get instance=>Get.find();
  final profileLoading=false.obs;
  final userRepository=Get.put(UserRepository());
  final verifyEmail=TextEditingController();
  final verifyPassword=TextEditingController();
  final hidePassword=false.obs;
  GlobalKey<FormState>reAuthFormKey=GlobalKey<FormState>();
  Rx<UserModel> user=UserModel.empty().obs;
@override
  void onInit(){
    super.onInit();
    fetchUserRecord();
  }
  Future<void> fetchUserRecord()async{
    try{
      profileLoading.value=true;
      final user =  await userRepository.fetchUserDetails();
      this.user(user);
      
    

    }catch(e){
      user(UserModel.empty());

    }finally{
      profileLoading.value=false;
    }
  }
  
  //save data for auth providers
  Future<void> saveUserRecord(UserCredential? userCredentials)async{
    try{
      //refresh user record
      await  fetchUserRecord();
      if (user.value.id.isEmpty){
              if (userCredentials!=null){
        //first and last name
        final nameParts=UserModel.nameparts(userCredentials.user!.displayName??'');
        final username=UserModel.generateUsername(userCredentials.user!.displayName??'');
        //map data
        final user=UserModel(id: userCredentials.user!.uid,
         firstName: nameParts[0], 
         lastName: nameParts.length>1?nameParts.sublist(1).join(''):'',
          userName: username, 
          email: userCredentials.user!.email??'', 
          phoneNumber: userCredentials.user!.phoneNumber??'', 
          profilePicture: userCredentials.user!.photoURL??'');

          await userRepository.saveUserRecord(user);

      }

      }



    }catch(e){
      TLoaders.errorSnackBar(title: 'Data not saved',message: 'Something went wrong while saving your data.You can re-save yourr data in your profile.');

    }
  }
  void deleteAccountWarningPopupp(){
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account?This action is irreversible',
      confirm: ElevatedButton(onPressed: ()async =>deleteUserAccount(),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red,side: BorderSide(color: Colors.red)),

       child: Padding(padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
       child: Text('Delete'),),
       ),
       cancel: OutlinedButton(onPressed: ()=>Navigator.of(Get.overlayContext!).pop(), child: Text('Cancel'))
    );
  }
  void deleteUserAccount()async{
    try{
      //reauth
      final auth= AuthenticationRepository.instance;
      final provider=auth.authUser!.providerData.map((e) => e.providerId).first;
      if(provider.isNotEmpty){
        //re verify
        if (provider=='google.com'){
          await auth.SignInWithGoogle();
          await auth.deleteAccount();
         // Get.to(()=>   LoginScreen());
        }
        else if(provider=='password'){
         // Get.to(()=>ReAuthLoginForm());

        }
      }
      else{
        print('---error---');


      }
    }catch(e){
      TLoaders.warningSnackBar(title: 'Oh Snap!',message: e.toString());
    }

  }

  Future<void> reAuthenticateEmailAndPassword()async{
    try{

            //check connectivity
      
    if (!reAuthFormKey.currentState!.validate()){
        return;
    }
    await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(),verifyPassword.text.trim());
    await AuthenticationRepository.instance.deleteAccount();
    Get.offAll(()=>LoginScreen());

  }catch(e){
      TLoaders.warningSnackBar(title: 'Oh Snap!',message: e.toString());

  }


}
uploadUserProfilePicture()async{
  try{

  
  final image=await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70,maxHeight: 512,maxWidth: 512);
  if (image!=null){
    final imageurl= await userRepository.uploadImage('Users/images/profile', image);
    //update user image record
    Map<String,dynamic> json ={'profilePicture':imageurl};
    await userRepository.updateSingleField(json);
    user.value.profilePicture=imageurl;
  TLoaders.successSnackBar(title: 'Congratulations',message: 'Your profile pic has been updated');
  }
  }catch(e){
    TLoaders.errorSnackBar(title: 'Oh Snap!',message: 'Something went wrong $e');
    print(e);
  }

}
}