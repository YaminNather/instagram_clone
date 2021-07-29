part of 'edit_profile_page_bloc.dart';

abstract class EditProfilePageEvent extends Equatable {
  const EditProfilePageEvent();

  @override
  List<Object> get props => [];
}

abstract class TextFieldChangedEvent extends EditProfilePageEvent {
  const TextFieldChangedEvent(this.value);

  final String value;
}

class WidgetLoadedEvent extends EditProfilePageEvent {
  const WidgetLoadedEvent();
}

class ChangedUsernameEvent extends TextFieldChangedEvent {
  const ChangedUsernameEvent(String value) : super(value);
}

class ChangedBioEvent extends TextFieldChangedEvent {
  const ChangedBioEvent(String value) : super(value);
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
