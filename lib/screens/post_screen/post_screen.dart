import 'package:bloc_practice/constants/app_strings.dart';
import 'package:bloc_practice/cubit/post_cubit/post_cubit.dart';
import 'package:bloc_practice/cubit/post_cubit/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/text_widget.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(title: AppStrings.postTitleText),
      ),
      body: SafeArea(
        child: BlocBuilder<PostCubit,PostState>(

          builder: (context, state) {
            if(state is PostLoadingState){
              return const Center(child: CircularProgressIndicator(),);
            }
            else if(state is PostLoadedState){
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  //debugPrint(state.posts!.length.toString());
                  return ListTile(
                    title: TextWidget(title: state.posts[index].title.toString(),),
                  );
              },);
            }else{
            return const Center(
              child: TextWidget(title: AppStrings.postErrorText,),
            );}
        },),
      ),
    );
  }
}
