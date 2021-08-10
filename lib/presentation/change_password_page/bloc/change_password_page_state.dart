part of 'change_password_page_bloc.dart';

abstract class ChangePasswordPageState extends Equatable {
  const ChangePasswordPageState();

  @override  
  List<Object?> get props => [];
}

class LoadingState extends ChangePasswordPageState {
  const LoadingState();
}

class LoadedState extends ChangePasswordPageState {
  const LoadedState(this.checkmarkEnabled, this.error);

  const LoadedState.initial() : checkmarkEnabled = false, error = "";

  LoadedState copyWith({bool? checkmarkEnabled, String? error}) {
    return new LoadedState(checkmarkEnabled ??  this.checkmarkEnabled, error ?? this.error);
  }

  @override
  List<Object> get props => [checkmarkEnabled, error];


  
  final bool checkmarkEnabled;
  final String error;
}
