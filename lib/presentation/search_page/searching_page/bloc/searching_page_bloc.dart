import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/authentication/authentication_service.dart';
import 'package:instagram_ui_clone/presentation/search_page/profile_page/profile_page_widget.dart';
import 'package:instagram_ui_clone/profile/profile.dart';

import '../../../../injector.dart';

part 'searching_page_event.dart';
part 'searching_page_state.dart';

class SearchingPageBloc extends Bloc<SearchingPageEvent, SearchingPageState> {
  SearchingPageBloc._(this._authenticationService, this._profileService) : 
  super(new SearchingPageState.initial());  

  factory SearchingPageBloc() {
    return SearchingPageBloc._(getIt<AuthenticationService>(), getIt<ProfileService>());
  }

  @override
  Stream<SearchingPageState> mapEventToState(final SearchingPageEvent event) async* {
    if(event is WidgetLoadedEvent)
      yield* onWidgetLoadedEvent(event);

    if(event is UpdateListEvent)
      yield* onUpdateListEvent(event);

    else if(event is ClickedProfileEvent)
      yield* onClickedProfileEvent(event);

    else if(event is ChangedSearchValueEvent)
      yield* onChangedSearchValueEvent(event);
  }

  Stream<SearchingPageState> onWidgetLoadedEvent(final WidgetLoadedEvent event) async* {
    add(const UpdateListEvent());
  }

  Stream<SearchingPageState> onUpdateListEvent(final UpdateListEvent event) async* {
    yield state.copyWith(loading: true);
    
    final BuiltList<ProfileDTO> foundProfiles = await _profileService.getSearchResults(
      await getCurrentUserId(), searchBarController.text
    );

    yield state.copyWith(foundProfiles: foundProfiles, loading: false);
  }  

  Stream<SearchingPageState> onClickedProfileEvent(final ClickedProfileEvent event) async* {  
    await Navigator.pushReplacement(
      event.pageContext, 
      new MaterialPageRoute(builder: (_) => new WProfilePage(userId: event.profile.userId))
    );
  }

  Stream<SearchingPageState> onChangedSearchValueEvent(final ChangedSearchValueEvent event) async* {
    final Timer? searchTimer = this.searchTimer;
    
    if(searchTimer != null) {
      searchTimer.cancel();
      this.searchTimer = null;
    }

    this.searchTimer = Timer( const Duration(milliseconds: 500), () => add(const UpdateListEvent()) );
  }

  Future<String> getCurrentUserId() async {
    return (await _authenticationService.getCurrentUser())!.uid;
  }

  void dispose() {
    searchTimer?.cancel();
    searchTimer = null;
  }



  final TextEditingController searchBarController = new TextEditingController();  
  Timer? searchTimer;

  final AuthenticationService _authenticationService;
  final ProfileService _profileService;
}
