import 'package:bloc_practice/constants/app_colors.dart';
import 'package:bloc_practice/screens/sign_in_screen/bloc/sign_in_bloc.dart';
import 'package:bloc_practice/screens/sign_in_screen/bloc/sign_in_event.dart';
import 'package:bloc_practice/screens/sign_in_screen/bloc/sign_in_state.dart';
import 'package:bloc_practice/utils/ui_helper.dart';
import 'package:bloc_practice/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_strings.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(title: AppStrings.signInWithEmailText),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                BlocBuilder<SignInBloc, SignInState>(
                    builder: (context, state) {
                      if (state is SignInErrorState) {
                        return TextWidget(title: state.errorMessage,
                          color: AppColors.redColor,);
                      } else {
                        return Container();
                      }
                    }
                ),

                UiHelper.horizontalSizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  onChanged: (_) {
                    BlocProvider.of<SignInBloc>(context).add(
                      SignInTextChangedEvent(emailController.text.trim(), passwordController.text.trim())
                    );
                  },
                  hintText: AppStrings.emailAddressText,
                  controller: emailController,
                ),
                UiHelper.horizontalSizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  onChanged: (_) {
                    BlocProvider.of<SignInBloc>(context).add(
                        SignInTextChangedEvent(emailController.text.trim(), passwordController.text.trim())
                    );
                  },
                  hintText: AppStrings.passwordText,
                  controller: passwordController,),
                UiHelper.horizontalSizedBox(
                  height: 20,
                ),
                BlocBuilder<SignInBloc, SignInState>(
                    builder: (context, state) {
                      if(state is SignInLoadingState){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      return CupertinoButton(
                        color: (state is SignInValidState)
                            ? AppColors.blueColor
                            : AppColors.greyColor,
                        onPressed: () {
                          if(state is SignInValidState) {
                            BlocProvider.of<SignInBloc>(context).add(
                                SignInSubmittedEvent(
                                    emailController.text.trim(),
                                    passwordController.text.trim())
                            );
                          }
                        },
                        child: const TextWidget(
                          title: AppStrings.signInText,
                        ),
                      );
                    }
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onChanged;

  const TextFieldWidget({
    Key? key,
    required this.hintText,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
