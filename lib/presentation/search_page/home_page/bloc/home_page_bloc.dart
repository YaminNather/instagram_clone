import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_ui_clone/authentication/authentication_service.dart';
import 'package:instagram_ui_clone/post/post.dart';

import '../../../../injector.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  factory HomePageBloc() {
    final HomePageBloc r = new HomePageBloc._(getIt<AuthenticationService>(), getIt<PostService>());    
    
    return r;
  }

  HomePageBloc._(this.authenticationService, this._postService) : super(const LoadingState());  

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if(event is WidgetLoadedEvent)
      yield* onWidgetLoadedEvent(event);
  }

  Stream<HomePageState> onWidgetLoadedEvent(final WidgetLoadedEvent event) async* {
    BuiltList<SearchPagePostDTO> posts = await _postService.getForSearchPage(await getCurrentUserId());


    yield new LoadedState(posts);
  }

  Future<String> getCurrentUserId() async {
    final User user = (await authenticationService.getCurrentUser())!;

    return user.uid;
  }



  final AuthenticationService authenticationService;
  final PostService _postService;
}
