import 'package:bloc_practice/core/network/api/api_service.dart';
import 'package:bloc_practice/model/post_model.dart';
import 'package:flutter/cupertino.dart';

import '../core/network/app_url.dart';

class PostViewModel{
  dynamic _posts;

  set posts(dynamic value) {
    _posts = value;
  }

  dynamic get posts => _posts;
  ApiServices apiServices = ApiServices();
  Future<List<PostModel>> fetchPosts() async{
    _posts= await apiServices.callGetApi(url: AppUrl.postEndPoint);
    posts=_posts;
    return posts;
    debugPrint('get response: ${_posts.length}');
  }
}