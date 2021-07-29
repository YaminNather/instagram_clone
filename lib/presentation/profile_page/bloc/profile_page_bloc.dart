import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram_ui_clone/authentication/authentication_service.dart';
import 'package:instagram_ui_clone/post/post.dart';
import 'package:instagram_ui_clone/post/profile_page_posts.dart';
import 'package:instagram_ui_clone/profile/profile.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

@injectable
class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  ProfilePageBloc(this._authenticationService, this._profileService, this._postService) 
  : super(const LoadingState());

  @override
  Stream<ProfilePageState> mapEventToState(ProfilePageEvent event) async* {
    if(event is WidgetLoadedEvent)
      yield* onWidgetLoadedEvent(event);    
    
    else if(event is ClickedEditProfileButtonEvent)
      yield* onClickedEditProfileButtonEvent(event);

    else if(event is ClickedSignOutButtonEvent)
      yield* onClickedSignOutButtonEvent(event);
  }

  Stream<ProfilePageState> onWidgetLoadedEvent(final WidgetLoadedEvent event) async* {
    final User user = (await _authenticationService.getCurrentUser())!;

    final ProfileDTO profile = (await _profileService.getProfile(user.uid))!;
    final ProfilePagePosts posts = await _postService.getForProfilePage(user.uid);

    yield new LoadedState(profile.username, profile.bio, profile.dpURL, posts);
  }

  Stream<ProfilePageState> onClickedEditProfileButtonEvent(final ClickedEditProfileButtonEvent event) async* {
    await Navigator.pushNamed(event.context, "Edit Profile Page");
  }

  Stream<ProfilePageState> onClickedSignOutButtonEvent(final ClickedSignOutButtonEvent event) async* {
    await _authenticationService.signOut();

    await Navigator.pushReplacementNamed(event.pageContext, "Authentication Page");
  }

  final AuthenticationService _authenticationService;
  final ProfileService _profileService;
  final PostService _postService;
}