part of 'sign_in_page_bloc.dart';

@immutable
abstract class SignInPageState extends Equatable {
  const SignInPageState();
}

class InputState extends SignInPageState {
  const InputState(this.emailAddress, this.emailAddressError, this.password, this.passwordError);

  const InputState.initial() : emailAddress = "", emailAddressError = "", password = "", passwordError = "";


  InputState copyWith({
    String? emailAddress, String? emailAddressError, String? password, String? passwordError
  }) {
    final InputState r = new InputState(
      emailAddress ?? this.emailAddress, emailAddressError ?? this.emailAddressError, 
      password ?? this.password, passwordError ?? this.passwordError
    );
    
    return r;
  }  

  @override
  List<Object?> get props => [emailAddress, emailAddressError, password, passwordError];

  final String emailAddress;
  final String emailAddressError;

  final String password;
  final String passwordError;  
}

class LoadingState extends SignInPageState {
  @override  
  List<Object?> get props => [];
}
