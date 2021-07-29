part of 'edit_profile_page_bloc.dart';

abstract class EditProfilePageState extends Equatable {
  const EditProfilePageState();
  
  @override
  List<Object> get props => [];
}

class LoadingState extends EditProfilePageState {
  const LoadingState();
}

class InputState extends EditProfilePageState {
  const InputState(this.username, this.bio, this.error, this.dpURL, this.dpPath);

  const InputState.initial() : 
  username = const TextWithError.initial(), bio = "", error = "", dpURL = "", dpPath = "";

  InputState copyWith({TextWithError? username, String? bio, String? error, String? dpURL, String? dpPath}) {
    return new InputState(
      username ?? this.username, bio ?? this.bio, error ?? this.error, dpURL ?? this.dpURL, 
      dpPath ?? this.dpPath
    );
  }

  @override
  List<Object> get props => [username, bio, error, dpURL, dpPath];



  final TextWithError username;
  final String bio;
  final String error;  
  final String dpURL;
  final String dpPath;  
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