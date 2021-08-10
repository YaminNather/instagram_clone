import 'package:flutter/material.dart';

class WIconToggleButton extends StatefulWidget {
  const WIconToggleButton({ 
    Key? key, required this.enabledIcon, required this.disabledIcon, this.value = false, this.onChanged
  }) : super(key: key);

  @override
  _WIconToggleButtonState createState() => _WIconToggleButtonState();


  
  final Widget disabledIcon;
  final Widget enabledIcon;
  final bool value;
  final void Function(bool)? onChanged;
}

class _WIconToggleButtonState extends State<WIconToggleButton> { 
  @override
  Widget build(BuildContext context) {
    final Widget icon = (widget.value) ? widget.enabledIcon : widget.disabledIcon;
    
    void onPressedCallback() {
      widget.onChanged?.call(!widget.value);
    }    

    return IconButton(icon: icon, onPressed: onPressedCallback);
  }    
}