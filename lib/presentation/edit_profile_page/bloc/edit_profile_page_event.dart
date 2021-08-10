part of 'edit_profile_page_bloc.dart';

abstract class EditProfilePageEvent extends Equatable {
  const EditProfilePageEvent();

  @override
  List<Object> get props => [];
}

class WidgetLoadedEvent extends EditProfilePageEvent {
  const WidgetLoadedEvent();
}

class FormChangedEvent extends EditProfilePageEvent{
  const FormChangedEvent();
}

class ChangedDPEvent extends EditProfilePageEvent {
  const ChangedDPEvent(this.path);


  final String path;
}

class ClickedChangeDPEvent extends EditProfilePageEvent {
  const ClickedChangeDPEvent(this.context);

  final BuildContext context;
}

class ClickedCheckmarkButtonEvent extends EditProfilePageEvent {
  const ClickedCheckmarkButtonEvent(this.context);


  final BuildContext context;
}

class ClickedChangePasswordEvent extends EditProfilePageEvent {
  const ClickedChangePasswordEvent(this.pageContext);

  final BuildContext pageContext;
}