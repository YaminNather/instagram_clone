import 'package:flutter/material.dart';

class WURL extends StatelessWidget {
  const WURL({required this.text, required this.onPressed, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    final MaterialStateProperty<Size> sizeStateProperty = MaterialStateProperty.all(Size.zero);
    MaterialStateProperty<EdgeInsets?> paddingStateProperty = MaterialStateProperty.all(
      const EdgeInsets.all(0.0)
    );
    final ButtonStyle style = new ButtonStyle(minimumSize: sizeStateProperty, padding: paddingStateProperty);

    return TextButton(child: Text(text), onPressed: onPressed, style: style);
  }


  final String text;
  final void Function()? onPressed;
}