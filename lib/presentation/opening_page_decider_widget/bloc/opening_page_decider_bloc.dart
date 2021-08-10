import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../authentication/authentication_service.dart';
import '../../../injector.dart';

part 'opening_page_decider_event.dart';
part 'opening_page_decider_state.dart';

class OpeningPageDeciderBloc extends Bloc<OpeningPageDeciderEvent, OpeningPageDeciderState> {
  OpeningPageDeciderBloc._(this._authenticationService) : super(const LoadingState());

  factory OpeningPageDeciderBloc() {
    return new OpeningPageDeciderBloc._(getIt<AuthenticationService>());
  }

  @override
  Stream<OpeningPageDeciderState> mapEventToState(OpeningPageDeciderEvent event) async* {
    if(event is WidgetLoadedEvent)
      yield* onWidgetLoadedEvent(event);
  }

  Stream<OpeningPageDeciderState> onWidgetLoadedEvent(final WidgetLoadedEvent event) async* {
    final User? user = await _authenticationService.getCurrentUser();

    yield new LoadedState(user != null);
  }
  


  final AuthenticationService _authenticationService;
}
