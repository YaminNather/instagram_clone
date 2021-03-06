import 'package:flutter/material.dart';

double getScaffoldBodyHeight(final BuildContext context) {
  final double screenHeight = MediaQuery.of(context).size.height;
  final double appBarHeight = Scaffold.of(context).appBarMaxHeight!;

  return screenHeight - appBarHeight;
}

void showSnackBarWithText(final BuildContext context, final String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}