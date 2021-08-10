import 'package:flutter/material.dart';

class Themes {
  Themes(this.isDark) : _buttonThemes = new _ButtonThemes(isDark);

  ThemeData getTheme() {
    return ThemeData(
      brightness: (isDark) ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: (isDark) ? Colors.black : ThemeData.light().scaffoldBackgroundColor,      
      appBarTheme: _getAppBarTheme(),
      tabBarTheme: _getTabBarTheme(),
      indicatorColor: Colors.black,
      elevatedButtonTheme: _buttonThemes.getElevatedButtonTheme(),
      outlinedButtonTheme: _buttonThemes.getOutlinedButtonTheme(),
      inputDecorationTheme: _getInputDecorationTheme(),      
      bottomNavigationBarTheme: _getBottomNavigationBarTheme()
    );
  }

  InputDecorationTheme _getInputDecorationTheme() {
    final OutlineInputBorder baseBorder = new OutlineInputBorder(
      borderSide: new BorderSide(color: Colors.grey[(isDark) ? 700 : 300]!)
    );

    final OutlineInputBorder focusedBorder = baseBorder.copyWith(
      borderSide: const BorderSide(color: Colors.blue)
    );

    final OutlineInputBorder errorBorder = baseBorder.copyWith(
      borderSide: const BorderSide(color: Colors.red)
    );

    final Color backgroundColor = (isDark) ? Colors.grey[900]! : Colors.grey[200]!;
    
    return new InputDecorationTheme(
      enabledBorder: baseBorder, focusedBorder: focusedBorder, errorBorder: errorBorder,
      border: baseBorder, filled: true, fillColor: backgroundColor, focusColor: backgroundColor, 
      hoverColor: backgroundColor
    );
  }

  AppBarTheme _getAppBarTheme() {
    final IconThemeData iconThemeData = new IconThemeData(color: (isDark) ? Colors.white : Colors.black);    
    final Color titleColor = (isDark) ? Colors.white : Colors.black;    

    return new AppBarTheme(
      backgroundColor: Colors.transparent, elevation: 0.0, iconTheme: iconThemeData,
      textTheme: new TextTheme(
        headline6: ThemeData.fallback().textTheme.headline6!.copyWith(fontSize: 16.0, color: titleColor)
      )
    );
  }

  BottomNavigationBarThemeData _getBottomNavigationBarTheme() {
    final Color iconColor = (isDark) ? Colors.white : Colors.black;

    return new BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed, 
      selectedIconTheme: new IconThemeData(color: iconColor),
      unselectedIconTheme: new  IconThemeData(color: iconColor),
      enableFeedback: false
    );
  }
 
  TabBarTheme _getTabBarTheme() {
    return const TabBarTheme(labelColor: Colors.black);
  }



  final bool isDark;
  final _ButtonThemes _buttonThemes;
}

class _ButtonThemes {
  const _ButtonThemes(this.isDark);

  OutlinedButtonThemeData getOutlinedButtonTheme() {
    final OutlinedBorder shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0));

    return new OutlinedButtonThemeData(
      style: _getBaseButtonStyle().copyWith(
        // side: MaterialStateProperty.all(),
        shape: MaterialStateProperty.all(shape),
        side: MaterialStateProperty.all(BorderSide(color: Colors.grey[(isDark) ? 800 : 400]!)),
        foregroundColor: MaterialStateProperty.all((isDark) ? Colors.white : Colors.black),
      )
    );
  }

  ElevatedButtonThemeData getElevatedButtonTheme() {
    return new ElevatedButtonThemeData(style: _getBaseButtonStyle());
  }

  static ButtonStyle _getBaseButtonStyle() {
    // const TextStyle textStyle = const TextStyle(fontWeight: FontWeight.w100);
    
    return new ButtonStyle(elevation: MaterialStateProperty.all(0.0));
  }



  final bool isDark;
}