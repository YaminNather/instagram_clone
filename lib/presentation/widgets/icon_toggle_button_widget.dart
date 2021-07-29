import 'package:flutter/material.dart';

class WIconToggleButton extends StatefulWidget {
  const WIconToggleButton({ 
    Key? key, required this.enabledIcon, required this.disabledIcon, this.onChanged
  }) : super(key: key);

  @override
  _WIconToggleButtonState createState() => _WIconToggleButtonState();


  final Widget disabledIcon;
  final Widget enabledIcon;
  final void Function(bool)? onChanged;
}

class _WIconToggleButtonState extends State<WIconToggleButton> {
  @override
  Widget build(BuildContext context) {
    final Widget icon = (enabled) ? widget.enabledIcon : widget.disabledIcon;
    
    void onPressedCallback() {
      toggleState();
      widget.onChanged?.call(enabled);
    }    

    return IconButton(icon: icon, onPressed: onPressedCallback);
  }

  void toggleState() => setState( () => enabled = !enabled );


  bool enabled = false;
}