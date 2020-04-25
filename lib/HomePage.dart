import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_project/Authentication/SignUpPage.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

      return HomePageState();
  }

}

class HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(title: Text("Home"),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          onPressed: _signOut,
        )
      ],
      ),
      body: Center(
        child: new Text("Welcome"),
      ),
    );

  }

  void _signOut() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut().then((res) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUp()));
    });
  }
}