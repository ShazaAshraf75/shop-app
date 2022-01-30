// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    //https://newsapi.org/
    dio = Dio(BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": token ?? null,
      "Content-Type": "application/json",
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": token ?? null,
      "Content-Type": "application/json",
    };
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": token ?? null,
      "Content-Type": "application/json",
    };
    return await dio.put(url, queryParameters: query, data: data);
  }
}
