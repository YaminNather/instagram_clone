import 'package:flutter/material.dart';

ButtonStyle getElevatedButtonStyle() {
  Color backgroundColorResolver(Set<MaterialState> states) {
    if(states.contains(MaterialState.disabled))
      return Colors.grey[200]!;

    return Colors.blue;
  }

  return _getBaseButtonStyle().copyWith(
    backgroundColor: MaterialStateProperty.resolveWith(backgroundColorResolver),
    foregroundColor: MaterialStateProperty.all(Colors.white)
  );
}

ButtonStyle getOutlinedButtonStyle() {
  return _getBaseButtonStyle().copyWith(
    side: MaterialStateProperty.all(const BorderSide(color: Colors.blue)),
    foregroundColor: MaterialStateProperty.all(Colors.blue)
  );
}

ButtonStyle _getBaseButtonStyle() {
  const TextStyle textStyle = const TextStyle(fontWeight: FontWeight.w100);
  
  return new ButtonStyle(textStyle: MaterialStateProperty.all(textStyle));
}