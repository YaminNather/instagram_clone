import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/authentication/authentication_service.dart';
import 'package:instagram_ui_clone/presentation/utils/widget_utils.dart';

import '../../../injector.dart';

part 'change_password_page_event.dart';
part 'change_password_page_state.dart';

class ChangePasswordPageBloc extends Bloc<ChangePasswordPageEvent, ChangePasswordPageState> {
  factory ChangePasswordPageBloc() {
    return ChangePasswordPageBloc._(getIt<AuthenticationService>());
  }

  ChangePasswordPageBloc._(this._authenticationService) : super(const LoadedState.initial());

  @override
  Stream<ChangePasswordPageState> mapEventToState(ChangePasswordPageEvent event) async* {
    if(event is FormChangedEvent)
      yield* onFormChangedEvent(event);

    else if(event is ClickedCheckmarkButtonEvent)
      yield* onClickedCheckmarkButtonEvent(event);
  }

  Stream<ChangePasswordPageState> onFormChangedEvent(final FormChangedEvent event) async* {
    final LoadedState loadedState = state as LoadedState;

    yield loadedState.copyWith(checkmarkEnabled: formKey.currentState!.validate());
  }

  Stream<ChangePasswordPageState> onClickedCheckmarkButtonEvent(ClickedCheckmarkButtonEvent event) async* {
    final LoadedState loadedState = state as LoadedState;
    final String currentPassword = currentPasswordController.text; 
    final String newPassword = newPasswordController.text;
    
    yield const LoadingState();

    try {
      await _authenticationService.updateCurrentUsersPassword(currentPassword, newPassword);

      showSnackBarWithText(event.pageContext, "Password changed");
      Navigator.pop(event.pageContext);
    }
    catch(e) {
      print(e);
      showSnackBarWithText(event.pageContext, "Failed to change password");
      yield loadedState.copyWith(error: "Password is wrong");
    }
  }

  bool currentPasswordValidator() {
    return _authenticationService.isValidPassword(currentPasswordController.text);    
  }

  bool newPasswordValidator() {
    if(newPasswordController.text == currentPasswordController.text)
      return false;

    return _authenticationService.isValidPassword(newPasswordController.text);
  }



  final AuthenticationService _authenticationService;
  
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final TextEditingController currentPasswordController = new TextEditingController();
  final TextEditingController newPasswordController = new TextEditingController();
}
