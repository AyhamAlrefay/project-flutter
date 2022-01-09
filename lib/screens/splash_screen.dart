import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/category/category.dart';
import 'package:project/screens/products/products.dart';
import 'package:project/screens/show_category/show_category.dart';
import 'package:project/screens/welcome.dart';
import 'package:project/shared/sharedpreferences.dart';
import 'package:project/screens/category/category.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> topCircleAnimation;
  Animation<double> bottomCircleAnimation;
  Animation<double> logoAnimation;
  AnimationController controller;

  String token=CacheHelper.getData(key: "token");

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration:Duration(seconds: 3), vsync: this);
    topCircleAnimation = Tween<double>(begin: 0, end: 200).animate(controller)..addListener(() {setState(() {});});
    bottomCircleAnimation = Tween<double>(begin: 0, end: 350).animate(controller)..addListener(() {setState(() {});});
    logoAnimation = Tween<double>(begin: 0, end: 1).animate(controller)..addListener(() {setState(() {});});
    controller.forward();

    Timer(Duration(seconds:5), () {
      if (token !=null) {
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) =>Products(),),);
      } else
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => WelcomeScreen(),),);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Image in the middle
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Opacity(
                opacity: logoAnimation.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/m6.png',fit: BoxFit.fitHeight,),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          //Container in top
          Positioned(
            top: -30,
            right: -100,
            child: Container(
              height: topCircleAnimation.value,
              width: topCircleAnimation.value,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.yellow.shade600,
                    Theme.of(context).primaryColor,
                    //Theme.of(context).accentColor,
                    Colors.red,
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          //Container in under
          Positioned(
            bottom: -100,
            left: -150,
            child: Container(
              height: bottomCircleAnimation.value,
              width: bottomCircleAnimation.value,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.yellow.shade600,
                    Theme.of(context).primaryColor,
                    //Theme.of(context).accentColor,
                    Colors.red,
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
