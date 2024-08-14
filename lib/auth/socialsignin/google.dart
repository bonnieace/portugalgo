import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi{
  static final _clientIDWeb='599405288410-lcb54pghjf2js9ituc1fuehbrg86bbb2.apps.googleusercontent.com';

  static final _googleSignIn = GoogleSignIn(clientId: _clientIDWeb);
  static Future<GoogleSignInAccount?> login()=>_googleSignIn.signIn();
  static Future logout()=>_googleSignIn.disconnect();

}