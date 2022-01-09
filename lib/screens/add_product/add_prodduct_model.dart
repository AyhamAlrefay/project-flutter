import 'package:flutter/material.dart';

class AddProductModel{
  var status;
  var msg;


  AddProductModel.fromJson(Map<String,dynamic> json){
    status=json["status"];
    msg=json["msg"];

  }
}