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
  const LoadedState(
    this.username, this.bio, this.dpURL, this.followingCount, this.followersCount, this.followDetails, this.posts
  );

  LoadedState copyWith({
    String? username, String? bio, String? dpURL, int? followingCount, int? followersCount,
    FollowingDetails? followDetails, ProfilePagePosts? posts
  }) {
    return new LoadedState(
      username ?? this.username, bio ?? this.bio, dpURL ?? this.dpURL,  followingCount ?? this.followingCount,
      followersCount ?? this.followersCount, followDetails ?? this.followDetails, posts ?? this.posts
    );
  }

  @override
  List<Object> get props => [username, bio, dpURL, followingCount, followersCount, followDetails, posts];



  final String username;
  final String bio;
  final String dpURL;
  final int followingCount;
  final int followersCount;
  final FollowingDetails followDetails;
  final ProfilePagePosts posts;
}

class FollowingDetails extends Equatable {
  const FollowingDetails(this.following, this.operation);

  FollowingDetails copyWith({bool? following, bool? operation}) {
    return new FollowingDetails(following ?? this.following, operation ?? this.operation);
  }

  @override
  List<Object> get props => [following, operation];



  final bool following;  
  final bool operation;
}