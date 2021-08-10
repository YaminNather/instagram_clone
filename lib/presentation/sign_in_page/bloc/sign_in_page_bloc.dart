import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram_ui_clone/authentication/authentication_service.dart';
import 'package:instagram_ui_clone/presentation/utils/widget_utils.dart';
import 'package:meta/meta.dart';

part 'sign_in_page_event.dart';
part 'sign_in_page_state.dart';
part 'on_clicked_sign_in_button_event.dart';

@injectable
class SignInPageBloc extends Bloc<SignInPageEvent, SignInPageState> {
  SignInPageBloc(this._authenticationService) : super(const InputState.initial());

  @override
  Stream<SignInPageState> mapEventToState(SignInPageEvent event) async* {
    if(event is ClickedGoogleSignInButtonEvent)
      yield* onClickedGoogleSignInButtonEvent(event);

    else if(event is ChangedEmailUsernameEvent)
      yield* onChangedEmailUsernameEvent(event);

    else if(event is ChangedPasswordEvent)
      yield* onChangedPasswordEvent(event);

    else if(event is ClickedSignInButtonEvent) {
      yield* onClickedSignInButtonEvent(event);
    }
  }

  Stream<SignInPageState> onClickedGoogleSignInButtonEvent(ClickedGoogleSignInButtonEvent event) async* {
    // final InputState previousInputState = state as InputState;    

    // yield LoadingState();

    // try {
    //   await _authenticationService.signInWithGoogle();

    //   await Navigator.pushReplacementNamed(event.context, "Logged In Page");
    // }
    // catch(e) {
    //   print(e);

    //   yield previousInputState.copyWith();
    // }    
  }

  Stream<SignInPageState> onChangedEmailUsernameEvent(ChangedEmailUsernameEvent event) async* {
    final InputState previousState = state as InputState;
    
    final String error;
    bool isValid = _authenticationService.isValidEmail(event.emailAddress);
    isValid = isValid || _authenticationService.isValidUsername(event.emailAddress);
    if(isValid)
      error = "";
    else
      error = "Enter valid email or username";    

    yield previousState.copyWith(emailAddress: event.emailAddress, emailAddressError: error);
  }

  Stream<SignInPageState> onChangedPasswordEvent(ChangedPasswordEvent event) async* {
    final InputState previousState = state as InputState;
    
    final String error;
    if(_authenticationService.isValidPassword(event.password))
      error = "";
    else
      error = "Enter valid password";

    yield previousState.copyWith(password: event.password, passwordError: error);
  }

  Stream<SignInPageState> onClickedSignInButtonEvent(ClickedSignInButtonEvent event) async* {
    OnClickedSignedInButtonEvent onClickedEvent = new OnClickedSignedInButtonEvent(this, event);

    yield* onClickedEvent.execute();
  }




  final AuthenticationService _authenticationService;
}
