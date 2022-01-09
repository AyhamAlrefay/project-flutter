import 'package:flutter/material.dart';

class LoginModel{
  bool status;
  String msg;
  String token;

  LoginModel.fromJson(Map<String,dynamic> json){
    status=json["status"];
    msg=json["msg"];
    token=json["access_token"];
  }
}