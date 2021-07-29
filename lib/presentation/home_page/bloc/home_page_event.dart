part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class WidgetLoadedEvent extends HomePageEvent {
  const WidgetLoadedEvent();
}

class NewPostsAvailableEvent extends HomePageEvent {
  const NewPostsAvailableEvent(this.posts);


  final Posts posts;
}
