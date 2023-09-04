import 'package:bloc_practice/cubit/post_cubit/post_state.dart';
import 'package:bloc_practice/model/post_model.dart';
import 'package:bloc_practice/view_model/post_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState>{
  PostCubit() : super(PostLoadingState()){
    fetchPosts();
  }

  PostViewModel postViewModel =PostViewModel();

  Future<List<PostModel>?> fetchPosts() async{
    try{
      List<PostModel> post= await postViewModel.fetchPosts();
      debugPrint('length => ${post.length.toString()}');
      debugPrint('length => ${postViewModel.fetchPosts().toString()}');
       emit(PostLoadedState(post));
      return null;
    }catch(e){
      emit(PostErrorState(e.toString()));
    }
  }
}