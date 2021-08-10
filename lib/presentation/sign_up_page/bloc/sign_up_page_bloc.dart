import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram_ui_clone/presentation/utils/widget_utils.dart';
import '../../../authentication/authentication_service.dart';

part 'sign_up_page_event.dart';
part 'sign_up_page_state.dart';

@injectable
class SignUpPageBloc extends Bloc<SignUpPageEvent, SignUpPageState> {
  SignUpPageBloc(this._authenticationService) : super(const InputState.initial());

  @override
  Stream<SignUpPageState> mapEventToState(SignUpPageEvent event) async* {  
    if(event is ChangedUsernameEvent)
      yield* onChangedUsernameEvent(event);
    
    else if(event is ChangedEmailEvent)
      yield* onChangedEmailAddressEvent(event);

    else if(event is ChangedPasswordEvent)
      yield* onChangedPasswordEvent(event);

    else if(event is ChangedConfirmPasswordEvent) {
      yield* onChangedConfirmPasswordEvent(event);
    }

    else if(event is ClickedSignUpButtonEvent)
      yield* onClickedSignUpButtonEvent(event);

    if(event is ClickedGoogleSignUpButtonEvent)
      yield* onClickedGoogleSignUpButtonEvent(event);
  }

  Stream<SignUpPageState> onChangedUsernameEvent(ChangedUsernameEvent event) async* {
    final InputState previousState = state as InputState;
    
    final String error;
    if(_authenticationService.isValidUsername(event.username))
      error = "";
    else
      error = "Enter valid username";
    
    yield previousState.copyWith(username: new TextWithError(event.username, error));
  }

  Stream<SignUpPageState> onChangedEmailAddressEvent(ChangedEmailEvent event) async* {
    final InputState previousState = state as InputState;
    
    final String error;
    if(_authenticationService.isValidEmail(event.emailAddress))
      error = "";
    else
      error = "Enter valid email";
    
    yield previousState.copyWith(emailAddress: new TextWithError(event.emailAddress, error));
  }

  Stream<SignUpPageState> onChangedPasswordEvent(ChangedPasswordEvent event) async* {
    final InputState previousState = state as InputState;
    
    final String error;
    if(_authenticationService.isValidPassword(event.password))
      error = "";
    else
      error = "Enter valid password";

    yield previousState.copyWith(password: new TextWithError(event.password, error));
  }

  Stream<SignUpPageState> onChangedConfirmPasswordEvent(ChangedConfirmPasswordEvent event) async* {
    final InputState previousState = state as InputState;
    
    final String error;
    if(event.confirmPassword != previousState.password.text)
      error = "Password is not the same";
    else 
      error = "";

    yield previousState.copyWith(confirmPassword: new TextWithError(event.confirmPassword, error));
  }

  Stream<SignUpPageState> onClickedGoogleSignUpButtonEvent(ClickedGoogleSignUpButtonEvent event) async* {
    final InputState previousInputState = state as InputState;    

    yield const LoadingState();

    try {
      // await _authenticationAppService.signInWithGoogle();

      // await Navigator.pushReplacementNamed(event.context, "Logged In Page");
    }
    catch(e) {
      print(e);

      yield previousInputState.copyWith();
    }    
  }

  Stream<SignUpPageState> onClickedSignUpButtonEvent(ClickedSignUpButtonEvent event) async* {  
    final InputState previousState = state as InputState;

    yield const LoadingState();
    
    try {      
      await _authenticationService.signUpWithEmailAndPassword(
        previousState.username.text, previousState.emailAddress.text, previousState.password.text
      );

      showSnackBarWithText(event.context, "Signed up");

      Navigator.pushNamedAndRemoveUntil(event.context, "Signed In Page", (_) => false);
    }
    catch(e) {
      print(e);
      showSnackBarWithText(event.context, "Couldnt Sign up");

      yield previousState.copyWith();
    }
  }



  final AuthenticationService _authenticationService;
}
