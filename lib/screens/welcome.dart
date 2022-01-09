import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/screens/category/category.dart';
import 'package:project/screens/login/login.dart';
import 'package:project/screens/products/products.dart';
import 'package:project/shared/sharedpreferences.dart';
import 'package:project/widgets/login_button_welcome.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> bottomContainerAnimation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    bottomContainerAnimation =
        Tween<double>(begin: -400, end: 0).animate(_controller)
          ..addListener(() {
            setState(() {});
          });
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/m6.png', height: 400, width: 500),
                SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            bottom: bottomContainerAnimation.value,
            left: 0,
            right: 0,
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.orange,
                /*gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.orange.shade300,
                    Theme.of(context).primaryColor,
                    //Theme.of(context).accentColor,

                    Colors.red.shade400,
                  ],
                ),*/
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "In this application you will see a lot of products that fascinate for you and attract your attention We wish you a wonderful surfing and a happy time.",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoginButtonInWel(
                          color: Colors.black,
                          text: 'LogIn',
                          onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginUiScreen()),
                                );
                          },
                          textColor: Colors.white,
                        ),
                        SizedBox(width: 20),
                        LoginButtonInWel(
                          color: Colors.white,
                          text: 'Show first',
                          onTap: () {
                            CacheHelper.saveData(key: "welcome", value: true)
                                .then((value) {
                              if (value) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Products()),
                                );
                              }
                            });
                          },
                          textColor: Colors.black,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
