part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();
  
  @override
  List<Object> get props => [];
}

class LoadingState extends HomePageState {
  const LoadingState();
}

class LoadedState extends HomePageState {
  const LoadedState(this.posts);

  @override  
  List<Object> get props => [...posts];

  final BuiltList<SearchPagePostDTO> posts;
}
