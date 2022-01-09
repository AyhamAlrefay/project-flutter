import 'package:flutter/material.dart';
import 'package:project/screens/login/login.dart';
import 'package:project/screens/splash_screen.dart';
import 'package:project/shared/sharedpreferences.dart';



void main() async {
WidgetsFlutterBinding.ensureInitialized();
await CacheHelper.init();
//bool welcome=CacheHelper.getData(key: "welcome");


  runApp(MyApp());

}

Color _primaryColor = Colors.orangeAccent;
Color _accentColor = Colors.deepOrange[600];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: _primaryColor,
                accentColor: _accentColor,
              ),
              home:SplashScreen() ,

            );


  }
}
