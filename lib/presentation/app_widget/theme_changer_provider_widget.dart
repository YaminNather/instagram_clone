import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/presentation/app_widget/app_widget.dart';

class WAppControllerProvider extends InheritedWidget {
  const WAppControllerProvider({ Key? key, required this.appController, required Widget child}) 
  : super(key: key, child: child);

  static WAppControllerProvider of(final BuildContext context) {
    final WAppControllerProvider? r = context.dependOnInheritedWidgetOfExactType<WAppControllerProvider>();
    assert(r != null, "No WThemeChangerProvider found in context");

    return r!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;


  final AppController appController;
}