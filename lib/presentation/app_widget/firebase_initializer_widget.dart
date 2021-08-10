import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class  WFirebaseInitializer extends StatelessWidget {
  const WFirebaseInitializer({ Key? key, required this.child }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: new Future(() => Firebase.initializeApp()),
      builder: (context, snapshot) {
        if(!snapshot.hasData)
          return const Text("Firebase Initialized");

        return child;
      },
    );
  }


  final Widget child;
}