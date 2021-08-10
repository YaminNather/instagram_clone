import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram_ui_clone/authentication/authentication_service.dart';
import 'package:instagram_ui_clone/post/post.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

@injectable
class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc(this._authenticationService, this._postService) : super(const LoadingState());

  @override
  Stream<HomePageState> mapEventToState(final HomePageEvent event) async* {
    if(event is WidgetLoadedEvent)
      yield* _onWidgetLoadedEvent(event);

    else if(event is NewPostsAvailableEvent)
      yield* _onNewPostsAvailableEvent(event);
  }

  Stream<HomePageState> _onWidgetLoadedEvent(final WidgetLoadedEvent event) async* {
    final Stream<List<PostDTO>> postsStream = _postService.getStreamForUsersFeed(await _getCurrentUsersId());

    postsStream.listen(
      (postsList) {
        print("CustomLog: Posts recieved from stream");
        add( NewPostsAvailableEvent(new Posts(postsList)) );
      }
    );
  }

  Stream<HomePageState> _onNewPostsAvailableEvent(final NewPostsAvailableEvent event) async* {
    print("CustomLog: Updating state");

    final HomePageState previousState = state;

    yield new LoadedState(event.posts);
  }

  Future<String> _getCurrentUsersId() async {
    final User user = (await _authenticationService.getCurrentUser())!;

    return user.uid;
  }



  final AuthenticationService _authenticationService;
  final PostService _postService;
}
