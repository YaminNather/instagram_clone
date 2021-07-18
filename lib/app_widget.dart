import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/auth_page/auth_page_widget.dart';
import 'package:instagram_ui_clone/dm_page/dm_page_widget.dart';
import 'package:instagram_ui_clone/global_provider.dart';
import 'package:instagram_ui_clone/sign_in_page/sign_in_page.dart';
import 'package:instagram_ui_clone/sign_up_page/sign_up_page_widget.dart';
import 'package:instagram_ui_clone/signed_in_page/signed_in_page_widget.dart';

class WApp extends StatelessWidget {
  const WApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalProvider(      
      child: MaterialApp(
        title: 'Flutter Demo', theme: _getTheme(),
        routes: <String, Widget Function(BuildContext)> {
          "Sign Up Page" : (_) => const WSignUpPage(),
          "Sign In Page" : (_) => const WSignInPage(),
          "Signed In Page" : (_) => const WSignedInPage(),
          "DM Page" : (_) => const WDMPage()
        },
        home: const WAuthPage(),
        debugShowCheckedModeBanner: false
      )
    );
  }

  ThemeData _getTheme() {
    final ThemeData r = ThemeData(
      primarySwatch: Colors.blue,      
      elevatedButtonTheme: _ButtonThemes.getElevatedButtonTheme(),
      outlinedButtonTheme: _ButtonThemes.getOutlinedButtonTheme(),
      inputDecorationTheme: _getInputDecorationTheme(),
      // textButtonTheme: _ButtonThemes.getTextButtonTheme(),
      appBarTheme: _getAppBarTheme(),
      bottomNavigationBarTheme: _getBottomNavigationBarTheme(),
      tabBarTheme: _getTabBarTheme(),
      indicatorColor: Colors.black
    );

    return r;
  }

  InputDecorationTheme _getInputDecorationTheme() {
    final OutlineInputBorder baseBorder = new OutlineInputBorder(
      borderSide: new BorderSide(color: Colors.grey[300]!)
    );

    final OutlineInputBorder focusedBorder = baseBorder.copyWith(
      borderSide: const BorderSide(color: Colors.blue)
    );

    final OutlineInputBorder errorBorder = baseBorder.copyWith(
      borderSide: const BorderSide(color: Colors.red)
    );

    final Color backgroundColor = Colors.grey[100]!;
    
    return new InputDecorationTheme(
      enabledBorder: baseBorder, focusedBorder: focusedBorder, errorBorder: errorBorder,
      border: baseBorder, filled: true, fillColor: backgroundColor, focusColor: backgroundColor, 
      hoverColor: backgroundColor
    );
  }

  AppBarTheme _getAppBarTheme() {
    const IconThemeData iconThemeData = const IconThemeData(color: Colors.black);    

    return const AppBarTheme(
      backgroundColor: Colors.transparent, elevation: 0.0, iconTheme: iconThemeData,
      textTheme: const TextTheme(headline6: const TextStyle(color: Colors.black))
    );
  }

  BottomNavigationBarThemeData _getBottomNavigationBarTheme() {
    return const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed, selectedIconTheme: const IconThemeData(color: Colors.black),
      unselectedIconTheme: const IconThemeData(color: Colors.black),
      enableFeedback: false
    );
  }

  TabBarTheme _getTabBarTheme() {
    return const TabBarTheme(labelColor: Colors.black);
  }  
}




class _ButtonThemes {
  static OutlinedButtonThemeData getOutlinedButtonTheme() {
    final OutlinedBorder shape = RoundedRectangleBorder(
      side: BorderSide(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(8.0)
    );

    return new OutlinedButtonThemeData(
      style: _getBaseButtonStyle().copyWith(
        // side: MaterialStateProperty.all(),
        shape: MaterialStateProperty.all(shape),
        foregroundColor: MaterialStateProperty.all(Colors.black),
      )
    );
  }

  static ElevatedButtonThemeData getElevatedButtonTheme() {
    return new ElevatedButtonThemeData(style: _getBaseButtonStyle());
  }

  static ButtonStyle _getBaseButtonStyle() {
    // const TextStyle textStyle = const TextStyle(fontWeight: FontWeight.w100);
    
    return new ButtonStyle(elevation: MaterialStateProperty.all(0.0));
  }
}