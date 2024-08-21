import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture
  });
  //helper function to get full name
  String get fullName=>'$firstName$lastName';

  //format number
  //String get formattedPhoneN=>TFormatter.formatPhoneNumber(phoneNumber);

  //splitt full name to first and last
  static List<String> nameparts(fullName)=>fullName.split('');
  //USERNAME GEN
  static String generateUsername(fullName){
    List<String> nameparts=fullName.split(' ');
    String firstName=nameparts[0].toLowerCase();
    String lastName=nameparts.length>1?nameparts[1].toLowerCase():'';
    String camelcaseusername = '$firstName$lastName';
    String usernamewithprefix='cwt_$camelcaseusername';

    return usernamewithprefix;
  }

  //static function to create an empty user model
  static UserModel empty()=>UserModel(id: '', firstName: '', lastName: '', userName: '', email: '', phoneNumber: '', profilePicture: '');

//convert model to json
Map<String,dynamic> toJson(){
  return{
    'FirstName':firstName,
    'LastName':lastName,
    "UserName":userName,
    'Email':email,
    "PhoneNumber":phoneNumber,
    "ProfilePicture":profilePicture
  };
}
//FACTOY METHOD TO CREATE A USERMODEL FROM A FIREBASE DOCUMENT SHOT
factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>>document){
  if (document.data()!=null){
    final data= document.data()!;
    return UserModel(
      id: document.id,
      firstName: data ['FirstName'] ??'',
       lastName:data['LastName']??'',
        userName: data['UserName']??'', email: data['Email']??'',
         phoneNumber: data['PhoneNumber']??'',
          profilePicture: data['profilePicture']??'',

    );
  }
  else{
    return UserModel.empty();
  }
}
}