import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_ui_clone/authentication/authentication_service.dart';
import 'package:instagram_ui_clone/follow/follow_service.dart';
import 'package:instagram_ui_clone/post/post.dart';
import 'package:instagram_ui_clone/post/profile_page_posts.dart';
import 'package:instagram_ui_clone/profile/profile.dart';

import '../../../../injector.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';


class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  factory ProfilePageBloc() {
    return new ProfilePageBloc._(
      getIt<AuthenticationService>(), getIt<ProfileService>(), getIt<PostService>(), getIt<FollowService>()
    );
  }
  
  ProfilePageBloc._(this._authenticationService, this._profileService, this._postService, this._followService)
  : super(const LoadingState());


  @override
  Stream<ProfilePageState> mapEventToState(ProfilePageEvent event) async* {
    if(event is WidgetLoadedEvent)
      yield* onWidgetLoadedEvent(event);

    if(event is InitialDataLoadedEvent)
      yield* onInitialDataLoadedEvent(event);

    else if(event is FollowersChangedEvent)
      yield* onFollowersChangedEvent(event);
    
    else if(event is ClickedFollowButtonEvent)
      yield* onClickedFollowButtonEvent(event);

    else if(event is FollowingChangedEvent)
      yield* onFollowingChangedEvent(event);
  }

  Stream<ProfilePageState> onWidgetLoadedEvent(final WidgetLoadedEvent event) async* {
    final ProfileDTO profile = (await _profileService.getProfile(event.userId))!;
    final ProfilePagePosts posts = await _postService.getForProfilePage(event.userId);

    _initialLoadedInfo = new InitialLoadedInfo(
      profile.username, profile.bio, profile.dpURL, posts, () => add(InitialDataLoadedEvent())
    );

    final Stream<BuiltList<String>> followersStream = _followService.getFollowersStream(event.userId);
    _followersStream = followersStream;
    _followersSubscription = followersStream.listen(
      (followers) async {
        final InitialLoadedInfo initialLoadedInfo = _initialLoadedInfo!;
        initialLoadedInfo.setFollowers(followers);

        await _followersSubscription!.cancel();        
      }
    );

    final Stream<BuiltList<String>> followingStream  = _followService.getFollowingStream(event.userId);  
    _followingStream = followingStream;
    _followingSubscription = followingStream.listen(
      (following) async {
        final InitialLoadedInfo initialLoadedInfo = _initialLoadedInfo!;
        initialLoadedInfo.setFollowing(following);

        await _followingSubscription!.cancel();        
      }    
    );
  }

  Stream<ProfilePageState> onInitialDataLoadedEvent(final InitialDataLoadedEvent event) async* {
    final InitialLoadedInfo initialLoadedInfo = _initialLoadedInfo!;
    final FollowingDetails followDetails = new FollowingDetails(
      initialLoadedInfo.getFollowers()!.contains(await _getCurrentUserId()), false
    );

    yield new LoadedState(
      initialLoadedInfo.username, initialLoadedInfo.bio, initialLoadedInfo.dpURL, 
      initialLoadedInfo.getFollowing()!.length, initialLoadedInfo.getFollowers()!.length, 
      followDetails, initialLoadedInfo.posts
    );

    _followersSubscription = _followersStream!.listen(
      (followers) => add(new FollowersChangedEvent(followers))
    );

    _followingSubscription = _followingStream!.listen(
      (following) => add(new FollowingChangedEvent(following))
    );    
  }

  Stream<ProfilePageState> onFollowingChangedEvent(final FollowingChangedEvent event) async* {
    final LoadedState loadedState = state as LoadedState;    
    
    yield loadedState.copyWith(followingCount: event.following.length);
  }  

  Stream<ProfilePageState> onFollowersChangedEvent(final FollowersChangedEvent event) async* {
    final LoadedState loadedState = state as LoadedState;
    final bool following = event.followers.contains(await _getCurrentUserId());

    final FollowingDetails newFollowingDetails = loadedState.followDetails.copyWith(following: following);
    
    yield loadedState.copyWith(followDetails: newFollowingDetails, followersCount: event.followers.length);
  }

  Stream<ProfilePageState> onClickedFollowButtonEvent(final ClickedFollowButtonEvent event) async* {
    print("CustomLog: Clicked Follow Button Event");
    final LoadedState loadedState = state as LoadedState;

    yield loadedState.copyWith(followDetails: loadedState.followDetails.copyWith(operation: true));

    if(!loadedState.followDetails.following)
      await _followService.follow(event.userId, await _getCurrentUserId());
    else
      await _followService.unfollow(event.userId, await _getCurrentUserId());

    yield loadedState.copyWith(followDetails: loadedState.followDetails.copyWith(operation: false));
  }

  Future<String> _getCurrentUserId() async {
    return (await _authenticationService.getCurrentUser())!.uid;
  }

  void dispose() {
    _followersSubscription?.cancel();
  }



  final AuthenticationService _authenticationService;
  final ProfileService _profileService;
  final PostService _postService;
  final FollowService _followService;
  Stream<BuiltList<String>>? _followersStream;
  Stream<BuiltList<String>>? _followingStream;
  StreamSubscription<BuiltList<String>>? _followersSubscription;
  StreamSubscription<BuiltList<String>>? _followingSubscription;

  InitialLoadedInfo? _initialLoadedInfo;
}

class InitialLoadedInfo {
  InitialLoadedInfo(this.username, this.bio, this.dpURL, this.posts, this.onLoaded);

  BuiltList<String>? getFollowers() {
    return _followers;
  }

  void setFollowers(final BuiltList<String> value) {
    _followers = value;
    checkForCompletion();
  }

  BuiltList<String>? getFollowing() {
    return _following;
  }
  
  void setFollowing(final BuiltList<String> value) {
    _following = value;
    checkForCompletion();
  }

  void checkForCompletion() {
    if(completelyLoaded())
      onLoaded();
  }

  bool completelyLoaded() {
    return _followers != null && _following != null;
  }  


  final String username;
  final String bio;
  final String dpURL;
  final ProfilePagePosts posts;
  BuiltList<String>? _followers;
  BuiltList<String>? _following;
  
  void Function() onLoaded;
}