import 'package:flutter/material.dart';

class WInstagramLogo extends StatelessWidget {
  const WInstagramLogo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String asset = (theme.brightness == Brightness.light) ?  lightThemeAsset : darkThemeAsset;

    return Image.asset(asset);
  }




  static String lightThemeAsset = "assets/instagram_logo/instagram_logo_light.png";
  static String darkThemeAsset = "assets/instagram_logo/instagram_logo_dark.png";
}