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
  const LoadedState(this.profile, this.followingCount, this.followersCount, this.posts);

  LoadedState copyWith({ProfileDTO? profile, int? followingCount, int? followersCount}) {
    return new LoadedState(
      profile ?? this.profile, followingCount ?? this.followingCount, followersCount ?? this.followersCount, 
      posts
    );
  }

  @override
  List<Object> get props => <Object>[profile, followingCount, followersCount, posts];



  final ProfileDTO profile;
  final int followingCount;
  final int followersCount;
  final ProfilePagePosts posts;
}
