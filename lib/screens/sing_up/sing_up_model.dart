import 'package:flutter/material.dart';

class SingUpModel{
  var status;
  var msg;
  var token;
 //String message;

  SingUpModel.fromJson(Map<String,dynamic> json){
    status=json["status"];
    msg=json["msg"];
    token=json["access_token"];
    //message=json["message"];
  }
}