import 'package:bloc_practice/bloc/internet_bloc/internet_bloc.dart';
import 'package:bloc_practice/cubit/internet_cubit.dart';
import 'package:bloc_practice/cubit/post_cubit/post_cubit.dart';
import 'package:bloc_practice/screens/home_screen/home_screen.dart';
import 'package:bloc_practice/screens/post_screen/post_screen.dart';
import 'package:bloc_practice/screens/sign_in_screen/bloc/sign_in_bloc.dart';
import 'package:bloc_practice/screens/sign_in_screen/sign_in_screen.dart';
import 'package:bloc_practice/view_model/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  PostViewModel postViewModel=PostViewModel();
  postViewModel.fetchPosts();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => InternetBloc(),),
        BlocProvider(
          create: (context) => InternetCubit(),),
        BlocProvider(
          create: (context) => SignInBloc(),),
        BlocProvider(
          create: (context) => PostCubit(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PostScreen(),
      ),
    );
  }
}
