part of 'sign_up_page_bloc.dart';

abstract class SignUpPageEvent extends Equatable {
  const SignUpPageEvent();  

  @override
  List<Object> get props => [];
}

class ClickedGoogleSignUpButtonEvent extends SignUpPageEvent {
  const ClickedGoogleSignUpButtonEvent(this.context);


  final BuildContext context;
}

class ChangedUsernameEvent extends SignUpPageEvent {
  const ChangedUsernameEvent(this.username);


  final String username;
}

class ChangedEmailEvent extends SignUpPageEvent {
  const ChangedEmailEvent(this.emailAddress);


  final String emailAddress;
}

class ChangedPasswordEvent extends SignUpPageEvent {
  const ChangedPasswordEvent(this.password);


  final String password;
}

class ChangedConfirmPasswordEvent extends SignUpPageEvent {
  const ChangedConfirmPasswordEvent(this.confirmPassword);


  final String confirmPassword;
}

class ClickedSignUpButtonEvent extends SignUpPageEvent {
  const ClickedSignUpButtonEvent(this.context);

  
  final BuildContext context;
}