part of 'change_password_page_bloc.dart';

abstract class ChangePasswordPageEvent extends Equatable {
  const ChangePasswordPageEvent();

  @override
  List<Object> get props => [];
}

class FormChangedEvent extends ChangePasswordPageEvent {
  const FormChangedEvent();
}

class ClickedCheckmarkButtonEvent extends ChangePasswordPageEvent {
  const ClickedCheckmarkButtonEvent(this.pageContext);


  final BuildContext pageContext;
}
