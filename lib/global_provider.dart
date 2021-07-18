import 'package:flutter/widgets.dart';

class GlobalProvider extends InheritedWidget {
  const GlobalProvider({required Widget child, Key? key}) 
  : super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant GlobalProvider oldWidget) => oldWidget.logoURLBig != logoURLBig;  
  
  static GlobalProvider of(final BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GlobalProvider>() as GlobalProvider;
  }
  

  
  final String logoURLBig = "https://pnglux.com/wp-content/uploads/2021/03/Instagram-PNG-logo-HD.png";
  final String logoURLSmall = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Instagram_logo.svg/1200px-Instagram_logo.svg.png";
}