import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/shared/sharedpreferences.dart';

var token=CacheHelper.getData(key: "token");
class DioHelper {
  static Dio dio;

  DioHelper() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: "http://192.168.43.180:8000/api/",
      receiveDataWhenStatusError: true,
      headers: {
        'Content-Type':'application/json',
        'Accept': 'application/json',
        'Authorization':'Bearer ${CacheHelper.getData(key: "token")}'
      },
    );
    dio = Dio(baseOptions);
  }

  static Future<Response> getData({
    @required String url,
     Map<String, dynamic> query,
    String token,
    String lang,
  }) async {
    var response= await dio.get(
      url,
      //queryParameters: query,
        );
    print(response.statusCode);
    return response;

  }

  static Future<Response> postData({
    @required String url,
    String token,
   // String lang,
     Map<String,dynamic> query,
    @required  dynamic data,
  }) async {
    var response = await dio.post(url,
        data: data);
print(response.statusCode);
    return response;
  }




  static Future<Response> postDataLikes({
    @required String url,
  }) async {
    var response = await dio.post(url);
    print(response.statusCode);
    return response;
  }



}
