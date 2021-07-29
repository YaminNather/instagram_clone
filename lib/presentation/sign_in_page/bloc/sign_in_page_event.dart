part of 'sign_in_page_bloc.dart';

@immutable
abstract class SignInPageEvent {}

class ClickedGoogleSignInButtonEvent extends SignInPageEvent {
  ClickedGoogleSignInButtonEvent(this.context);


  final BuildContext context;
}

class ChangedEmailUsernameEvent extends SignInPageEvent {
  ChangedEmailUsernameEvent(this.emailAddress);


  final String emailAddress;
}

class ChangedPasswordEvent extends SignInPageEvent {
  ChangedPasswordEvent(this.password);


  final String password;
}

class ClickedSignInButtonEvent extends SignInPageEvent {
  ClickedSignInButtonEvent(this.context);


  final BuildContext context;  
}