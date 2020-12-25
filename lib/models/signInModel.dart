import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInModel {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookLogin _facebookLogin = FacebookLogin();

  Future<User> signInGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
    return currentUser;
  }
Future<bool> isGoogleSignedIn()async{
    bool result = await _googleSignIn.isSignedIn();
    return result;
}
  Future signOutGoogle() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
  }

  Future<void> signInFacebook() async {
    final FacebookLoginResult result = await _facebookLogin.logIn(['email']);
    final FacebookAccessToken facebookAccessToken = result.accessToken;
    final AuthCredential credential =
        FacebookAuthProvider.credential(facebookAccessToken.token);
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
    return currentUser;
  }
  Future<bool> isFacebookSignedIn()async{
    bool result = await _facebookLogin.isLoggedIn;
    return result;
  }
  Future signOutFacebook() async {
    await FirebaseAuth.instance.signOut();
    await _facebookLogin.logOut();
  }
}
