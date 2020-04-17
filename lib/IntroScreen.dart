import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:test_project/HomePage.dart';
import 'package:test_project/Authentication/SignUpPage.dart';



class IntroScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return IntroScreenState();
  }

}

class IntroScreenState extends State<IntroScreen>{


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser().then((res){
      print(res);
      if(res != null){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
      else{
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUp()),
        );
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new SplashScreen(
      seconds: 5,
      title: new Text('Welcome to my test Project',
      style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
      image: Image.asset("assets/splash.png"),
      backgroundColor: Colors.red,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=> print("Flutter"),
      loaderColor: Colors.white,

    );

  }
}