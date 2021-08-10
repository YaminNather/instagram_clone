part of 'profile_page_bloc.dart';

abstract class ProfilePageEvent extends Equatable {
  const ProfilePageEvent();

  @override
  List<Object> get props => [];
}

class WidgetLoadedEvent extends ProfilePageEvent {
  const WidgetLoadedEvent(this.userId);

  final String userId;
}

class ClickedFollowButtonEvent extends ProfilePageEvent {
  const ClickedFollowButtonEvent(this.userId);

  final String userId;
}

class FollowersChangedEvent extends ProfilePageEvent {
  const FollowersChangedEvent(this.followers);


  final BuiltList<String> followers;
}

class FollowingChangedEvent extends ProfilePageEvent {
  const FollowingChangedEvent(this.following);


  final BuiltList<String> following;
}

class InitialDataLoadedEvent extends ProfilePageEvent {
    
}