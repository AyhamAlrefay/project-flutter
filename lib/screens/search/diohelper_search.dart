import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/shared/sharedpreferences.dart';

var token=CacheHelper.getData(key: "token");
class DioHelperSearch {
  static Dio dio;

  DioHelperSearch() {
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
  }) async {
    var response= await dio.get(
      url,
    );
    print(response.statusCode);
    return response;
  }
}
