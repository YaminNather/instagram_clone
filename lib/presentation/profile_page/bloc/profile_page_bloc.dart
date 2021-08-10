import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram_ui_clone/authentication/authentication_service.dart';
import 'package:instagram_ui_clone/follow/follow_service.dart';
import 'package:instagram_ui_clone/post/post.dart';
import 'package:instagram_ui_clone/post/profile_page_posts.dart';
import 'package:instagram_ui_clone/profile/profile.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

@injectable
class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  ProfilePageBloc(this._authenticationService, this._profileService, this._postService, this._followService) 
  : super(const LoadingState());

  @override
  Stream<ProfilePageState> mapEventToState(ProfilePageEvent event) async* {
    if(event is WidgetLoadedEvent)
      yield* onWidgetLoadedEvent(event);    
    
    else if(event is ClickedEditProfileButtonEvent)
      yield* onClickedEditProfileButtonEvent(event);

    else if(event is ProfileChangedEvent)
      yield* onProfileChangedEvent(event);

    else if(event is FollowingChangedEvent)
      yield* onFollowingChangedEvent(event);

    else if(event is FollowersChangedEvent)
      yield* onFollowersChangedEvent(event);

    else if(event is ClickedSignOutButtonEvent)
      yield* onClickedSignOutButtonEvent(event);
  }

  Stream<ProfilePageState> onWidgetLoadedEvent(final WidgetLoadedEvent event) async* {
    final User user = (await _authenticationService.getCurrentUser())!;

    final ProfileDTO profile = (await _profileService.getProfile(user.uid))!;
    final ProfilePagePosts posts = await _postService.getForProfilePage(user.uid);
        
    yield new LoadedState(profile, 0, 0, posts);

    final profileStream = _profileService.getProfileStream(await _getCurrentUserId());
    _profileSubscription = profileStream.listen((event) => add(new ProfileChangedEvent(event)));

    final followingStream = _followService.getFollowingStream(await _getCurrentUserId());
    _followingSubscription = followingStream.listen((event) => add(new FollowingChangedEvent(event.length)));

    final followersStream = _followService.getFollowersStream(await _getCurrentUserId());
    _followersSubscription = followersStream.listen((event) => add(new FollowersChangedEvent(event.length)));    
  }

  Stream<ProfilePageState> onClickedEditProfileButtonEvent(ClickedEditProfileButtonEvent event) async* {
    await Navigator.pushNamed(event.context, "Edit Profile Page");
  }

  Stream<ProfilePageState> onProfileChangedEvent(final ProfileChangedEvent event) async* {
    final LoadedState loadedState = state as LoadedState;
    
    yield loadedState.copyWith(profile: event.profile);
  }

  Stream<ProfilePageState> onFollowersChangedEvent(final FollowersChangedEvent event) async* {
    final LoadedState loadedState = state as LoadedState;

    yield loadedState.copyWith(followersCount: event.followersCount);
  }

  Stream<ProfilePageState> onFollowingChangedEvent(final FollowingChangedEvent event) async* {
    final LoadedState loadedState = state as LoadedState;

    yield loadedState.copyWith(followingCount: event.followingCount);
  }

  Stream<ProfilePageState> onClickedSignOutButtonEvent(final ClickedSignOutButtonEvent event) async* {
    await _authenticationService.signOut();

    await Navigator.pushReplacementNamed(event.pageContext, "Authentication Page");
  }

  Future<String> _getCurrentUserId() async {
    final User user = (await _authenticationService.getCurrentUser())!;
    
    return user.uid;
  }

  void dispose() {
    _profileSubscription!.cancel();

    _followingSubscription!.cancel();
    _followingSubscription = null;
    
    _followersSubscription!.cancel();
    _followingSubscription = null;
  }



  final AuthenticationService _authenticationService;
  final ProfileService _profileService;
  final PostService _postService;
  final FollowService _followService;

  StreamSubscription<BuiltList<String>>? _followingSubscription;
  StreamSubscription<BuiltList<String>>? _followersSubscription;
  StreamSubscription<ProfileDTO>? _profileSubscription;
}