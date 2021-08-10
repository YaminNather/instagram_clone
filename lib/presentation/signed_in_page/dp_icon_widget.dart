import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/profile/profile.dart';
import 'package:instagram_ui_clone/profile/profile_service.dart';

import '../../injector.dart';

class WDPIcon extends StatefulWidget {
  const WDPIcon({ Key? key }) : super(key: key);

  @override
  _WDPIconState createState() => _WDPIconState();
}

class _WDPIconState extends State<WDPIcon> {
  @override
  void initState() {
    super.initState();

    _listenToProfileStream();
  }

  Future<void> _listenToProfileStream() async {
    final ProfileService profileService = getIt<ProfileService>();
    
    final profileStream = profileService.getProfileStream(FirebaseAuth.instance.currentUser!.uid);
    subscription = profileStream.listen((event) => setState(() => profile = event));
  }

  @override
  Widget build(BuildContext context) {
    final ProfileDTO? profile = this.profile;

    return CircleAvatar(
      radius: 12.0, 
      foregroundImage: (profile == null) ? null : NetworkImage(profile.dpURL)
    );
  }

  @override
  void dispose() {
    subscription?.cancel();

    super.dispose();
  }



  StreamSubscription<ProfileDTO>? subscription;
  ProfileDTO? profile;
}