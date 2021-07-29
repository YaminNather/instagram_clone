part of 'sign_up_page_bloc.dart';

abstract class SignUpPageState extends Equatable {
  const SignUpPageState();  
}

class InputState extends SignUpPageState {
  const InputState(this.username, this.emailAddress, this.password, this.confirmPassword);

  const InputState.initial() : 
  username = const TextWithError.initial(),
  emailAddress = const TextWithError.initial(), 
  password = const TextWithError.initial(),
  confirmPassword = const TextWithError.initial();

  InputState copyWith({
    TextWithError? username, TextWithError? emailAddress, TextWithError? password, 
    TextWithError? confirmPassword
  }) {
    final InputState r = new InputState(
      username ?? this.username, emailAddress ?? this.emailAddress, password ?? this.password, 
      confirmPassword ?? this.confirmPassword
    );
    
    return r;
  }

  @override
  List<Object?> get props => [username, emailAddress, password, confirmPassword];


  final TextWithError username;
  final TextWithError emailAddress;
  final TextWithError password;
  final TextWithError confirmPassword;
}

class LoadingState extends SignUpPageState {
  const LoadingState();

  @override  
  List<Object?> get props => [];
}

@immutable
class TextWithError extends Equatable {
  const TextWithError(this.text, this.error);

  const TextWithError.initial() : text = "", error = "";

  bool isEmpty() {
    return text.isEmpty;
  }  

  bool isValid() {
    return error.isEmpty;
  }

  bool isNotEmptyAndValid() {
    return !isEmpty() && isValid();
  }

  TextWithError copyWith({String? text, String? error}) {
    return new TextWithError(text ?? this.text, error ?? this.error);
  }

  @override  
  List<Object?> get props => [text, error];



  final String text;
  final String error;
}