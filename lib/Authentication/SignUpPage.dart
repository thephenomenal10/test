import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:test_project/Authentication/SignInPage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'EmailSignUpPage.dart';

class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignUpState();

  }

}

class SignUpState extends State<SignUp>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("Flutter"),
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            Padding(
                padding: EdgeInsets.all(10.0),
                child: SignInButton(
                  Buttons.Email,
                  text: "Sign up with Email",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmailSignUp()),
                    );
                  },
                )),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () {
                    signInWithGoogle();
                  },
                )),


            Padding(
              padding: EdgeInsets.all(20.0),
              child: RaisedButton(
                color: Colors.orange,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmailSignIn()),
                    );
                  },
                child: Text('Login With Email'),
              ),
            )
          ],
        ),
      ),

    );

  }



  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }
}


