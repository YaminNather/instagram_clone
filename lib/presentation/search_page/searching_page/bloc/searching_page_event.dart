part of 'searching_page_bloc.dart';

abstract class SearchingPageEvent extends Equatable {
  const SearchingPageEvent();

  @override
  List<Object> get props => [];
}

class WidgetLoadedEvent extends SearchingPageEvent {
  const WidgetLoadedEvent();
}

class UpdateListEvent extends SearchingPageEvent {
  const UpdateListEvent();
}

class ChangedSearchValueEvent extends SearchingPageEvent {
  const ChangedSearchValueEvent();
}

class ClickedProfileEvent extends SearchingPageEvent {
  const ClickedProfileEvent(this.profile, this.pageContext);


  final ProfileDTO profile;
  final BuildContext pageContext;
}