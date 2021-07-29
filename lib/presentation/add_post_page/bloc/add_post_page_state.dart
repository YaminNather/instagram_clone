part of 'add_post_page_bloc.dart';

abstract class AddPostPageState extends Equatable {
  const AddPostPageState();
  
  @override
  List<Object> get props => [];
}

class LoadingState extends AddPostPageState {
  const LoadingState();
}

class InitialState extends AddPostPageState {
  const InitialState();
}