import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'injector.dart';
import 'presentation/app_widget/app_widget.dart';

void main() {
  configureDependencies();

  WidgetsFlutterBinding.ensureInitialized();  

  preloads().then( (_) => runApp(const WApp()) );
}

Future<void> preloads() async {
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]);
}