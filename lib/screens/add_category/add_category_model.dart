import 'package:flutter/material.dart';

class AddCategoryModel{
  var status;
  var msg;


  AddCategoryModel.fromJson(Map<String,dynamic> json){
    status=json["status"];
    msg=json["msg"];

  }
}