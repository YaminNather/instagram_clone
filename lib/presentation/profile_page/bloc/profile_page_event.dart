part of 'profile_page_bloc.dart';

abstract class ProfilePageEvent extends Equatable {
  const ProfilePageEvent();

  @override
  List<Object> get props => [];
}

class WidgetLoadedEvent extends ProfilePageEvent {
  const WidgetLoadedEvent();
}

class ClickedEditProfileButtonEvent extends ProfilePageEvent {
  const ClickedEditProfileButtonEvent(this.context);


  final BuildContext context;
}

class ClickedSignOutButtonEvent extends ProfilePageEvent {
  const ClickedSignOutButtonEvent(this.pageContext);


  final BuildContext pageContext;
}

class ProfileChangedEvent extends ProfilePageEvent {
  const ProfileChangedEvent(this.profile);


  final ProfileDTO profile;
}

class FollowingChangedEvent extends ProfilePageEvent {
  const FollowingChangedEvent(this.followingCount);


  final int followingCount;
}

class FollowersChangedEvent extends ProfilePageEvent {
  const FollowersChangedEvent(this.followersCount);


  final int followersCount;
}