import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../user_model.dart';
import '../auth_repository.dart';
import '../exceptions/firebase_auth_exceptions.dart';
import '../exceptions/firebase_exceptions.dart';
import '../exceptions/format_exceptions.dart';
import '../exceptions/platform_exceptions.dart';


class UserRepository extends GetxController{
  static UserRepository get instance =>Get.find();
  final FirebaseFirestore _db=FirebaseFirestore.instance;

  Future<void> saveUserRecord(UserModel user)async{
    try{
      await _db.collection('Users').doc(user.id).set(user.toJson());

    }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
        throw TFirebaseException(e.code).message;
    }on FormatException  catch(_){
      throw TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }
  }
  //fetch data based on id
    Future<UserModel> fetchUserDetails()async{
    try{
      final documentSnapshot= await _db.collection('Users').doc(AuthenticationRepository.instance.authUser?.uid).get();
      if(documentSnapshot.exists){
        return UserModel.fromSnapshot(documentSnapshot);
      }else{
        return UserModel.empty();
      }

    }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
        throw TFirebaseException(e.code).message;
    }on FormatException  catch(_){
      throw TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }
  }

  //update data
    Future<void> updateUserData(UserModel updatedUser)async{
    try{
      await _db.collection('Users').doc(updatedUser.id).update(updatedUser.toJson());

    }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
        throw TFirebaseException(e.code).message;
    }on FormatException  catch(_){
      throw TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }
  }

  //any field
  Future<void> updateSingleField( Map<String,dynamic> json)async{
    try{
      await _db.collection('Users').doc(AuthenticationRepository.instance.authUser?.uid).update(json);


    }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
        throw TFirebaseException(e.code).message;
    }on FormatException  catch(_){
      throw TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }
  }
  //remove data
    Future<void> removeUserRecord(String userId)async{
    try{
      await _db.collection('Users').doc(userId).delete();


    }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
        throw TFirebaseException(e.code).message;
    }on FormatException  catch(_){
      throw TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }
  }

  Future<String> uploadImage(String path,XFile image)async{
    try{
      final ref=FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url=await ref.getDownloadURL();
      return url;

    }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
        throw TFirebaseException(e.code).message;
    }on FormatException  catch(_){
      throw TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }
    
    
  }


}

