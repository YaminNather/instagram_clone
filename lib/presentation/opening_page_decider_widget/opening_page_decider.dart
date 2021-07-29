import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/authentication/authentication_service.dart';
import 'package:instagram_ui_clone/injector.dart';
import 'package:instagram_ui_clone/presentation/auth_page/auth_page_widget.dart';
import 'package:instagram_ui_clone/presentation/signed_in_page/signed_in_page_widget.dart';

class WOpeningPageDecider extends StatelessWidget {
  WOpeningPageDecider({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _authenticationService.getCurrentUser(),
      builder: (_, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: CircularProgressIndicator.adaptive());

        if(snapshot.data == null)
          return const WAuthPage();

        return const WSignedInPage();
      },
    );
  }

  final AuthenticationService _authenticationService = getIt();
}