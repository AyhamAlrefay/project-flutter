import 'package:flutter/material.dart';

class LoginButtonInWel extends StatelessWidget {
  final Color color;
  final String text;
  final Function onTap;
  final Color textColor;

  const LoginButtonInWel({
    Key key,
    @required this.color,
    @required this.text,
    @required this.onTap,
    @required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:color ),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)
          )
      ),
    );
  }
}