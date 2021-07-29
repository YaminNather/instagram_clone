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