import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../post/likes_service.dart';
import '../../../../../authentication/authentication_service.dart';
import '../../../../../post/post.dart';

import '../../../../../injector.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc._(this._authenticationService, this._likesService, PostState state) : super(state);

  factory PostBloc() {
    final PostBloc r = new PostBloc._(
      getIt<AuthenticationService>(),  getIt<LikesService>(), const PostState(false, false)
    );

    return r;
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if(event is WidgetLoadedEvent)
      yield* onWidgetLoadedEvent(event);
    
    else if(event is ClickedLikeButtonEvent)
      yield* onClickedLikeButtonEvent(event);
  }

  Stream<PostState> onWidgetLoadedEvent(final WidgetLoadedEvent event) async* {
    final bool liked = await checkIfLiked(event.post);

    yield new PostState(liked, false);
  }
  
  Stream<PostState> onClickedLikeButtonEvent(final ClickedLikeButtonEvent event) async* {
    final PostDTO post = event.postDTO;
    final String currentUserId = await getCurrentUsersId();
    
    yield state.copyWith(tryingToLike: true);

    if(post.likes.contains(currentUserId)) {
      _showSnackBarFunction(event.pageContext, "Removed Like from post");
      await _likesService.unlikePost(post.postId, currentUserId);
      yield state.copyWith(liked: false, tryingToLike: false);
    }
    else {
      _showSnackBarFunction(event.pageContext, "Liked post");
      await _likesService.likePost(post.postId, currentUserId);      
      yield state.copyWith(liked: true, tryingToLike: false);
    }
  }

  void _showSnackBarFunction(final BuildContext context, final String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<String> getCurrentUsersId() async {
    return (await _authenticationService.getCurrentUser())!.uid;
  } 

  Future<bool> checkIfLiked(final PostDTO post) async {
    return post.likes.contains(await getCurrentUsersId());
  }  



  final AuthenticationService _authenticationService;
  final LikesService _likesService;  
}