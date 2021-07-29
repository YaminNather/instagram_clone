part of 'profile_page_bloc.dart';

abstract class ProfilePageState extends Equatable {
  const ProfilePageState();
  
  @override
  List<Object> get props => [];
}

class LoadingState extends ProfilePageState {
  const LoadingState();
}

class LoadedState extends ProfilePageState {
  const LoadedState(this.username, this.bio, this.dpURL, this.posts);

  @override
  List<Object> get props => [username, bio, dpURL, posts];


  final String username;
  final String bio;
  final String dpURL;
  final ProfilePagePosts posts;
}
