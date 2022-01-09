import 'package:flutter/material.dart';

class ThemeHelper {
  InputDecoration textInputProduct
      ({ @required String lableText,@required String hintText,@required Widget icon ,bool percent=false})
  {
    return InputDecoration(
      prefixIcon: icon,
      labelText: lableText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,//for appear color grey when mouse refer to it
       suffixText: percent?"%":"",
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(80.0),
          borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(80.0),
          borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(80.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),

    );
  }

  InputDecoration textInputDecoration(
  { @required String lableText ,@required String hintText ,@required Widget icon}) {
    return InputDecoration(
      prefixIcon: icon,
      labelText: lableText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,//for appear color grey when mouse refer to it

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(80.0),
          borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(80.0),
          borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(80.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),

    );
  }


  BoxDecoration buttonBoxDecoration(BuildContext context) {
    Color color1 = Theme.of(context).primaryColor;
    Color color2 = Theme.of(context).accentColor;
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color1, color2],
      ),
      borderRadius: BorderRadius.circular(30),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
     // minimumSize: MaterialStateProperty.all(Size(50, 50)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  AlertDialog alartDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
