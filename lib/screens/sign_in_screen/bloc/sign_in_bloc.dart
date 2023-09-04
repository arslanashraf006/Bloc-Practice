import 'package:bloc_practice/constants/app_strings.dart';
import 'package:bloc_practice/screens/sign_in_screen/bloc/sign_in_event.dart';
import 'package:bloc_practice/screens/sign_in_screen/bloc/sign_in_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent,SignInState>{
  SignInBloc() : super(SignInInitialState()){
    on<SignInTextChangedEvent>((event, emit) {
      if(EmailValidator.validate(event.emailValue)==false){
        emit(SignInErrorState(AppStrings.emailErrorText));
      }else if(event.passwordValue.length<8){
        emit(SignInErrorState(AppStrings.passwordErrorText));
      }else{
        emit(SignInValidState());
      }
    });
    on<SignInSubmittedEvent>((event, emit) {
      emit(SignInLoadingState());
    });
  }
}