part of "sign_in_page_bloc.dart";

class OnClickedSignedInButtonEvent {
  OnClickedSignedInButtonEvent(this._bloc, this.event);

  Stream<SignInPageState> execute() async* {
    final InputState previousState = _bloc.state as InputState;

    yield LoadingState();
    
    try {
      if(_isEmailAddress(previousState.emailAddress))
        await _signInWithEmail(previousState.emailAddress, previousState.password);
      else
        await _signInWithUsername(previousState.emailAddress, previousState.password);

      showSnackBarWithText(event.context, "Signed in.");

      Navigator.pushNamedAndRemoveUntil(event.context, "Signed In Page", (_) => false);
    }
    catch(e) {
      print(e);
      showSnackBarWithText(event.context, "Couldnt Sign in.");

      yield previousState.copyWith();
    }
  }

  Future<void> _signInWithEmail(String emailAddress, String password) async {
    await _bloc._authenticationService.signInWithEmailAndPassword(emailAddress, password);
  }
  
  Future<void> _signInWithUsername(final String username, final String password) async {
    await _bloc._authenticationService.signInWithUsernameAndPassword(username, password);
  }

  bool _isEmailAddress(final String value) {
    return _bloc._authenticationService.isValidEmail(value);
  }



  final SignInPageBloc _bloc;
  final ClickedSignInButtonEvent event;
}