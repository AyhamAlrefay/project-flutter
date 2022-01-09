import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/shared/sharedpreferences.dart';


class DioHelperCategory {
  static Dio dio;

  DioHelperCategory() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: "http://192.168.43.180:8000/api/",
      //receiveDataWhenStatusError: true,
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

    );
    print(response.statusCode);
    return response;

  }


  static Future<Response> getDataOne({
    @required String url,
    @required String idCategory,
    Map<String, dynamic> query,
    String token,
    String lang,
  }) async {
    var response= await dio.get(
      url+idCategory,

      //queryParameters: query,
    );
    print(response.statusCode);
    return response;

  }


  static Future<Response> deleteCategory({
    @required String url,
    @required String idCategory,
  }) async {
    var response= await dio.get(
      url+idCategory,);
    print(response.statusCode);
    return response;
  }

static Future<Response> postData({
    @required String url,
    @required  dynamic data,
  }) async {

    var response = await dio.post(url,
        data: data);
    print(response.statusCode);
    return response;
  }
}
