part of 'opening_page_decider_bloc.dart';

abstract class OpeningPageDeciderEvent extends Equatable {
  const OpeningPageDeciderEvent();

  @override
  List<Object> get props => [];
}

class WidgetLoadedEvent extends OpeningPageDeciderEvent {
  const WidgetLoadedEvent(this.pageContext);


  final BuildContext pageContext;
}
