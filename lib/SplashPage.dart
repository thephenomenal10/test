import 'package:flutter/material.dart';
import 'package:test_project/IntroScreen.dart';




class Splash extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zomato',
      theme: ThemeData(primarySwatch: Colors.red),
      home: IntroScreen(),
    );
  }

}