import 'package:flutter/material.dart';
import 'injector.dart';
import 'presentation/app_widget.dart';

void main() {
  configureDependencies();

  runApp(const WApp());
}