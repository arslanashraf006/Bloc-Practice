import 'package:bloc_practice/model/post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../app_url.dart';

class ApiServices{
   Future<dynamic> callGetApi(
      {required String url,
        String baseUrl = AppUrl.baseUrl,
        dynamic model,
      }) async {
    try {
      BaseOptions options = BaseOptions(
        contentType: 'application/json',
        baseUrl: baseUrl,
      );

      var dio = Dio(options);
      Response _response = await dio.get(
        url,
      );
      //debugPrint('get response: ${_response.data}');
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        List<dynamic>? posts=_response.data;
        dynamic modelObj = posts?.map((postMap) => PostModel.fromJson(postMap)).toList();
        return modelObj;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }
}