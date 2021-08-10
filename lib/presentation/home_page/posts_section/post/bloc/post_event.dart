part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class WidgetLoadedEvent extends PostEvent {
  const WidgetLoadedEvent(this.post);


  final PostDTO post;
}

class ChangeLikeEvent extends PostEvent {
  const ChangeLikeEvent(this.value);


  final bool value;
}

class ClickedLikeButtonEvent extends PostEvent {
  const ClickedLikeButtonEvent(this.pageContext, this.postDTO);


  final BuildContext pageContext;
  final PostDTO postDTO;
}