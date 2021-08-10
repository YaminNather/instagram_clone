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
  const InputState(this.checkmarkEnabled, this.error, this.dpURL, this.dpPath);

  const InputState.initial() : checkmarkEnabled = false, error = "", dpURL = "", dpPath = "";

  InputState copyWith({bool? checkmarkEnabled, String? error, String? dpURL, String? dpPath}) {
    return new InputState(
      checkmarkEnabled ?? this.checkmarkEnabled, error ?? this.error, dpURL ?? this.dpURL,
      dpPath ?? this.dpPath
    );
  }

  @override
  List<Object> get props => [checkmarkEnabled, error, dpURL, dpPath];


  final bool checkmarkEnabled;
  final String error;
  final String dpURL;
  final String dpPath;
}