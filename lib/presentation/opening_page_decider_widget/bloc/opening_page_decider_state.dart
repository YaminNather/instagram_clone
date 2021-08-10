part of 'opening_page_decider_bloc.dart';

abstract class OpeningPageDeciderState extends Equatable {
  const OpeningPageDeciderState();
  
  @override
  List<Object> get props => [];
}

class LoadingState extends OpeningPageDeciderState {
  const LoadingState();
}

class LoadedState extends OpeningPageDeciderState {
  const LoadedState(this.signedIn);

  @override
  List<Object> get props => [signedIn];

  final bool signedIn;
}