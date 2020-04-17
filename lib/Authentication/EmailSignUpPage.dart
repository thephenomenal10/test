
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:test_project/HomePage.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class EmailSignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EmailSignUpState();
  }
  
}

class EmailSignUpState extends State<EmailSignUp>{

  final _formKey = new GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child('Users');
//  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    ageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return new Scaffold(
        appBar:  new AppBar(
          title: new Text('Signup'),
          backgroundColor: Colors.teal,
        ),
        body: new Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: "Enter your name",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          )
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return "anter your name";
                        }
                        return null;
                      }
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: "Enter your Email",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          )
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: validateEmail
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: ageController,
                      decoration: InputDecoration(
                          labelText: "Enter your age",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          )
                      ),
                      keyboardType: TextInputType.number,
                      validator: validatePassword
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: "Enter your password",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          )
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: validatePassword,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: RaisedButton(
                      color: Colors.orange,
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          return _handleEmailSignUp();
                        }
                      },
                      child: Text('Submit'),
                    ),
                  )
                ],
              ),
            )
        ),
      );
  }

  void _handleEmailSignUp() async{
    await firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text)
        .then((result){
        dbRef.child(result.user.uid).set({
          "email": emailController.text,
          "age": ageController.text,
          "name": nameController.text
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );



    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
    });
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {

      return 'Enter Valid Email';
    }
    else {

      return null;
    }

  }

  String validatePassword(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length < 6) {

      return 'Password must be of atleast 6 digit';
    }
    else {

      return null;
    }
  }


}



