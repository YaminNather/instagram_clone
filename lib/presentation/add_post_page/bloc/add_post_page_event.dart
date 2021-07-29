part of 'add_post_page_bloc.dart';

abstract class AddPostPageEvent extends Equatable {
  const AddPostPageEvent();

  @override
  List<Object> get props => [];
}

class ClickedPickMediaButtonEvent extends AddPostPageEvent {
  const ClickedPickMediaButtonEvent(this.mediaToPick, this.imageSource, this.pageContext);

  final MediaType mediaToPick;
  final ImageSource imageSource;
  final BuildContext pageContext;
}
